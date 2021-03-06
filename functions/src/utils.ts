import {UserRecord} from "firebase-functions/lib/providers/auth";
import {CallableContext} from "firebase-functions/lib/providers/https";
import * as functions from "firebase-functions";
import * as logging from "@google-cloud/logging";
import {ApiResponse} from "@google-cloud/logging/build/src/log";
import * as firebase_admin from "firebase-admin";
import Stripe from 'stripe';
import paymentIntents from "stripe";



const logger = new logging.Logging();

const memory = "128MB";
export const admin = firebase_admin.initializeApp();
export const db = admin.firestore();
export const stripe = new Stripe('sk_test_51IYAezDzzwMCjHARQrevkeA8uMdUCL7IYF4EVD3cvaqEuIpKIE3W8jrEKGWc5DMDpCTerG6PiVIRExXiL2CD7Tm100fosQUO33', {
    apiVersion: '2020-08-27'
});

export function adminVisibilityForState(state: ReservationState | null) {
    return state === ReservationState.PAYMENT_RESERVED || state === ReservationState.CHECKING_OUT
}

export function clientVisibilityForState(state: ReservationState | null) {
    return state !== null && state !== ReservationState.CHECKED_OUT
}



export function intentToStatus(intent: paymentIntents.PaymentIntent): ReservationState | null {
    if (intent.status === "succeeded") {
        return null
    } else if (intent.status === "requires_capture") {
        return ReservationState.PAYMENT_RESERVED
    } else if (intent.status === "requires_action") {
        return ReservationState.PAYMENT_AUTH_REQUIRED
    } else if (intent.status === "requires_payment_method") {
        return ReservationState.PAYMENT_METHOD_REQUIRED
    } else if (intent.status === "canceled") {
        return null
    } else if (intent.status === "processing") {
        console.error(intent.status);
        return null
    } else if (intent.status === "requires_confirmation") {
        console.error(intent.status);
        return null
        // return ReservationState.REQUIRES_CONFIRMATION
    }
    return null
}// @ts-ignore
/**
 * Convenience function to create a https call function.
 * @param handler The call handler
 */
export function onCall(handler: (data: any, context: functions.https.CallableContext) => any) {
    return functions.runWith({ memory: memory }).https.onCall(handler);
}

/**
 * Gets the firebase UID of the user who invoked the function.
 * @param context
 */
export function getRequestingUserId(context: CallableContext) {
  
    return context.auth === undefined ? 'SOOeDEEz0lWM3TxwegdD0d99bCA3' : context.auth.uid;
}

// noinspection JSUnusedGlobalSymbols
export async function getStripeCustomerId(userId: string): Promise<string> {


    const user = await admin.auth().getUser(userId);
    // @ts-ignore
    return getStripeCustomerIdForUser(user);

}

export async function getStripeCustomerIdForUser(user: UserRecord): Promise<string | null> {
    if (user.customClaims && user.customClaims.hasOwnProperty('stripeId')) {
        return (user.customClaims as any).stripeId
    } else {
        console.error(Error(`Missing customClaims.stripeID for user: ${user.uid}`));
        return null
    }
}

export async function reportError(err: any, context = {}): Promise<ApiResponse> {
    // This is the name of the StackDriver log stream that will receive the log
    // entry. This name can be any valid log stream name, but must contain "err"
    // in order for the error to be picked up by StackDriver Error Reporting.
    const logName = 'errors';
    const log = logger.log(logName);

    // https://cloud.google.com/logging/docs/api/ref_v2beta1/rest/v2beta1/MonitoredResource
    const meta = {
        resource: {
            type: 'cloud_functions', labels: {
                // @ts-ignore
                'function_name': process.env.FUNCTION_NAME.toString()
            }
        }
    };

    // https://cloud.google.com/error-reporting/reference/rest/v1beta1/ErrorEvent
    const errorEvent = {
        message: err.stack,
        serviceContext: {
            service: process.env.FUNCTION_NAME,
            resourceType: 'cloud_function',
        },
        context: context,
    };

    return log.write(log.entry(meta, errorEvent));
}

export enum HangerState {
    AVAILABLE,
    TAKEN
}

export enum ReservationState { // noinspection JSUnusedGlobalSymbols
    NONE, PAYMENT_METHOD_REQUIRED, PAYMENT_AUTH_REQUIRED, PAYMENT_RESERVED, CHECKED_IN, LOST, CHECKING_OUT, CHECKED_OUT
}
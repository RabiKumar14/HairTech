import * as functions from "firebase-functions";
import {getRequestingUserId, getStripeCustomerId, stripe} from "../utils";

export async function createAutomaticPaymentIntentHandler(data: any, context: functions.https.CallableContext) {
  // @ts-ignore
  const customerId = await getStripeCustomerId(getRequestingUserId(context));
  const amount = data.amount;
  const email = data.email;

  const intent = await stripe.paymentIntents.create({
    customer: customerId,
    amount: amount,
    currency: "SGD",
    receipt_email: email,
  });
  return {status: intent.status, clientSecret: intent.client_secret};
}

import 'package:Beautech/admin/dev_adminside/product_edit_data.dart';
import 'package:Beautech/models/appointment.dart';
import 'package:Beautech/models/product.dart';
import 'package:Beautech/models/salon.dart';
import 'package:Beautech/services/export_services.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AppointmentDataTable extends StatefulWidget {
  final Salon salon;

  const AppointmentDataTable({Key key, this.salon}) : super(key: key);
  @override
  _AppointmentDataTableState createState() => _AppointmentDataTableState();
}

class _AppointmentDataTableState extends State<AppointmentDataTable> {
  bool sort = false;
  @override
  Widget build(BuildContext context) {
    List<Appointment> appointment = Provider.of<List<Appointment>>(context);
    List<Appointment> listAppointment;

    onSortColum(int columnIndex, bool ascending) {
      if (columnIndex == 0) {
        if (ascending) {
          appointment
              .sort((a, b) => a.appointmentTime.compareTo(b.appointmentTime));
        } else {
          appointment
              .sort((a, b) => b.appointmentTime.compareTo(a.appointmentTime));
        }
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: Scrollbar(
            isAlwaysShown: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataTable(
                        sortColumnIndex: 0,
                        sortAscending: sort,
                        columns: <DataColumn>[
                          DataColumn(
                              label: Text(
                                'Appointment Date',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.pink),
                              ),
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  sort = !sort;
                                });
                                onSortColum(columnIndex, ascending);
                              }),
                          DataColumn(
                            label: Text(
                              'Customer Name',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.pink),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Service',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.pink),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Outlet',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.pink),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Status',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.pink),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Appointment status',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.pink),
                            ),
                          ),
                        ],
                        rows: appointment
                            .map((element) => DataRow(cells: [
                                  DataCell(
                                    Text(element.appointmentTime
                                        .toString()
                                        .substring(
                                            0,
                                            element.appointmentTime
                                                .toString()
                                                .lastIndexOf(":"))),
                                  ),
                                  DataCell(
                                    Text(element.appointmentUserName),
                                  ),
                                  DataCell(
                                    Text(element.appointmentService),
                                  ),
                                  DataCell(
                                    Container(
                                        width: 150,
                                        child: Text(
                                          element.appointmentSalonOutlet,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  ),
                                  DataCell(
                                    Text(element.appointmentStatus),
                                  ),
                                  DataCell(Row(
                                    children: [
                                      OutlinedButton(
                                          onPressed: () {
                                            CRUD().updateAppointment("Completed",
                                                element.appointmentID);
                                            setState(() {});
                                          },
                                          child: Text("Mark Completed")),
                                      SizedBox(width: 10),
                                      OutlinedButton(
                                          onPressed: () {
                                            CRUD().updateAppointment("Cancelled",
                                                element.appointmentID);
                                            setState(() {});
                                          },
                                          child: Text("Cancel & Refund")),
                                      SizedBox(width: 10),
                                      OutlinedButton(
                                          onPressed: () {
                                            CRUD().updateAppointment("Active",
                                                element.appointmentID);
                                            setState(() {});
                                          },
                                          child: Text("Mark Active"))
                                    ],
                                  )),
                                ]))
                            .toList()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

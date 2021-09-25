import 'dart:convert';

import "package:flutter/material.dart";
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import "dart:io";

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  // All final variables
  final _formKey = GlobalKey<FormState>();
  final _eventTitle = TextEditingController();
  final _eventSubTitle = TextEditingController();
  final _eventDescription = TextEditingController();
  final _eventCategory = TextEditingController();
  final _eventRegistrationLink = TextEditingController();
  final _totalSeats = TextEditingController();
  final _khojiType = TextEditingController();
  final _eventLocation = TextEditingController();

  //Variables whose state might change
  var setDateTimeText = "Schedule Event Dates";
  var setDateTimeTextReg = "Set Registation Dates";
  var thumbnailText = "Upload Thumbnail";

  var doneText = "Set";
  var doneTextReg = "Set";

  var startDateTime = DateTime.now();
  var endDateTime = DateTime.now().add(const Duration(days: 1));
  var eventStartDateText = "Event Start Date";
  var eventEndDateText = "Event End Date";
  var startTimeToShow = "Not Set";
  var endTimeToShow = "Not Set";

  var startDateTimeReg = DateTime.now();
  var endDateTimeReg = DateTime.now().add(const Duration(days: 3));
  var eventStartDateTextReg = "Registrations open from";
  var eventEndDateTextReg = "Registrations open till";
  var startTimeToShowReg = "Not Mentioned";
  var endTimeToShowReg = "Not Mentioned";

  //variables to pass in api calling
  var eventTitle;
  var eventSubTitle;
  var description;
  var eventStartDatetime;
  var eventEndDatetime;
  var activateDatetime;
  var deactivateDatetime;
  var category;
  var registerationLink;
  var totalSeats;
  var khojiType;
  var thumbnail;
  var location;

  var disable = true;

  submit(context) async {
    await Future.delayed(const Duration(milliseconds: 800));
    print("submit");
    var response = await pushInfo();
    if (response.body == 'true') {
      //TODO: Call to next page
    }
  }

  Future<http.Response> pushInfo() async {
    // var api = PackageApp.baseUrl +
    //     'tgf/khoji/register'; // {https://localhost:8080/ :: Need to be used from configuration file}
    var api = 'http://localhost:8080/tgf/portal/add-event';
    var url = Uri.parse(api);
    // data object
    Map eventDataRequestBody = {
      "eventTitle": eventTitle,
      "eventSubTitle": eventSubTitle,
      "description": description,
      "eventStartDatetime": eventStartDatetime,
      "eventEndDatetime": eventEndDatetime,
      "activateDatetime": activateDatetime,
      "deactivateDatetime": deactivateDatetime,
      "category": category,
      "registerationLink": registerationLink,
      "totalSeats": totalSeats,
      "khojiType": khojiType,
      "thumbnail": thumbnail,
      "location": location,
      "createdBy": 1,
      "createdDateTime": DateTime.now().toString()
    };
    //encode Map to JSON
    print(eventDataRequestBody.toString());
    var body = json.encode(eventDataRequestBody);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.reasonPhrase}");
    print("${response.body}");
    return response;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 25),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "Add a New Event",
                                style: TextStyle(
                                  color: Color(0xFF4a417f),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "You can add multiple events",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: TextFormField(
                                    controller: _eventTitle,
                                    onChanged: (value) => {
                                          setState(() {
                                            eventTitle = _eventTitle.text;
                                          }),
                                        },
                                    maxLength: 50,
                                    decoration: InputDecoration(
                                      labelText: "Event Title",
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        disable = true;
                                        return "Event title cannot be empty!";
                                      } else {
                                        disable = false;
                                      }
                                      return null;
                                    }),
                                width: 500,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: TextFormField(
                                    controller: _eventSubTitle,
                                    onChanged: (value) => {
                                          setState(() {
                                            eventSubTitle = _eventSubTitle.text;
                                          }),
                                        },
                                    maxLength: 50,
                                    decoration: InputDecoration(
                                      labelText: "Event Sub-Title",
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        disable = true;
                                        return "Event sub-title cannot be empty!";
                                      } else {
                                        disable = false;
                                      }
                                      return null;
                                    }),
                                width: 500,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: TextFormField(
                                    controller: _eventDescription,
                                    onChanged: (value) => {
                                          setState(() {
                                            description =
                                                _eventDescription.text;
                                          }),
                                        },
                                    minLines: 5,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    maxLength: 250,
                                    decoration: InputDecoration(
                                      labelText: "Event Description",
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        disable = true;
                                        return "Event description cannot be empty!";
                                      } else {
                                        disable = false;
                                      }
                                      return null;
                                    }),
                                width: 500,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: TextFormField(
                                    controller: _eventLocation,
                                    onChanged: (value) => {
                                          setState(() {
                                            location = _eventLocation.text;
                                          }),
                                        },
                                    decoration: InputDecoration(
                                      labelText: "Event Location",
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        disable = true;
                                        return "Event location cannot be empty!";
                                      } else {
                                        disable = false;
                                      }
                                      return null;
                                    }),
                                width: 500,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: TextFormField(
                                    controller: _eventCategory,
                                    onChanged: (value) => {
                                          setState(() {
                                            category = _eventCategory.text;
                                          }),
                                        },
                                    decoration: InputDecoration(
                                      labelText: "Event Category",
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        disable = true;
                                        return "Event category cannot be empty!";
                                      } else {
                                        disable = false;
                                      }
                                      return null;
                                    }),
                                width: 500,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: TextFormField(
                                    controller: _khojiType,
                                    onChanged: (value) => {
                                          setState(() {
                                            khojiType = _khojiType.text;
                                          }),
                                        },
                                    decoration: InputDecoration(
                                      labelText: "Khoji Type",
                                      labelStyle: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        disable = true;
                                        return "Khoji type cannot be empty!";
                                      } else {
                                        disable = false;
                                      }
                                      return null;
                                    }),
                                width: 500,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: TextFormField(
                                  controller: _totalSeats,
                                  onChanged: (value) => {
                                    setState(() {
                                      totalSeats = _totalSeats.text;
                                    }),
                                  },
                                  maxLength: 6,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "Available Seats",
                                    labelStyle: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      disable = true;
                                      return "Please mention available seats";
                                    } else {
                                      disable = false;
                                    }
                                    return null;
                                  },
                                ),
                                width: 500,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF4a417f),
                                  ),
                                  onPressed: () async {
                                    var file = await ImagePicker.platform
                                        .pickImage(source: ImageSource.gallery);
                                    setState(() {
                                      thumbnailText =
                                          (file!.path.toString().isNotEmpty)
                                              ? file.path.toString()
                                              : "ThumbnailImage";
                                      thumbnail = "http://tempurl.com/img1.png";
                                    });
                                  },
                                  icon: const Icon(Icons.upload),
                                  label: Text(thumbnailText)),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: TextFormField(
                                  controller: _eventRegistrationLink,
                                  onChanged: (value) => {
                                    setState(() {
                                      registerationLink =
                                          _eventRegistrationLink.text;
                                    }),
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Registration Link",
                                    labelStyle: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (!Uri.parse(value.toString())
                                        .isAbsolute) {
                                      disable = true;
                                      return "Enter a valid URL";
                                    } else {
                                      disable = false;
                                    }
                                    return null;
                                  },
                                ),
                                width: 500,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton.icon(
                                  icon: const Icon(Icons.calendar_today),
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF4a417f),
                                  ),
                                  onPressed: () {
                                    DateTimeRangePicker(
                                        startText: "From",
                                        endText: "To",
                                        doneText: doneTextReg,
                                        cancelText: "Cancel",
                                        interval: 5,
                                        initialStartTime: startDateTimeReg,
                                        initialEndTime: endDateTimeReg,
                                        mode:
                                            DateTimeRangePickerMode.dateAndTime,
                                        minimumTime: DateTime.now()
                                            .subtract(const Duration(days: 5)),
                                        maximumTime: DateTime.now()
                                            .add(const Duration(days: 25)),
                                        use24hFormat: false,
                                        onConfirm: (start, end) {
                                          setState(() {
                                            setDateTimeTextReg =
                                                "Update Registration Dates";
                                            doneTextReg = "Update";
                                            startDateTimeReg = start;
                                            endDateTimeReg = end;
                                            startTimeToShowReg =
                                                DateFormat.yMMMMd()
                                                    .addPattern(",")
                                                    .add_jm()
                                                    .format(start)
                                                    .toString();
                                            endTimeToShowReg =
                                                DateFormat.yMMMMd()
                                                    .addPattern(",")
                                                    .add_jm()
                                                    .format(end)
                                                    .toString();
                                            activateDatetime = start.toString();
                                            deactivateDatetime = end.toString();
                                          });
                                          print(start);
                                          print(end);
                                          if (startTimeToShowReg
                                                  .contains("Not") ||
                                              startTimeToShow.contains("Not")) {
                                            disable = true;
                                          } else {
                                            disable = false;
                                          }
                                        }).showPicker(context);
                                  },
                                  label: Text(
                                    setDateTimeTextReg,
                                    textAlign: TextAlign.center,
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                eventStartDateTextReg,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(startTimeToShowReg,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF4a417f),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                eventEndDateTextReg,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(endTimeToShowReg,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF4a417f),
                                  )),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton.icon(
                                  icon: const Icon(Icons.calendar_today),
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF4a417f),
                                  ),
                                  onPressed: () {
                                    DateTimeRangePicker(
                                        startText: "From",
                                        endText: "To",
                                        doneText: doneText,
                                        cancelText: "Cancel",
                                        interval: 5,
                                        initialStartTime: startDateTime,
                                        initialEndTime: endDateTime,
                                        mode:
                                            DateTimeRangePickerMode.dateAndTime,
                                        minimumTime: DateTime.now()
                                            .subtract(const Duration(days: 5)),
                                        maximumTime: DateTime.now()
                                            .add(const Duration(days: 25)),
                                        use24hFormat: false,
                                        onConfirm: (start, end) {
                                          setState(() {
                                            setDateTimeText =
                                                "Update Event Schedule";
                                            doneText = "Update";
                                            startDateTime = start;
                                            endDateTime = end;
                                            startTimeToShow =
                                                DateFormat.yMMMMd()
                                                    .addPattern(",")
                                                    .add_jm()
                                                    .format(start)
                                                    .toString();
                                            endTimeToShow = DateFormat.yMMMMd()
                                                .addPattern(",")
                                                .add_jm()
                                                .format(end)
                                                .toString();
                                            eventStartDatetime =
                                                start.toString();
                                            eventEndDatetime = end.toString();
                                          });
                                          if (startTimeToShow.contains("Not") ||
                                              startTimeToShowReg
                                                  .contains("Not")) {
                                            disable = true;
                                          } else {
                                            disable = false;
                                          }
                                          print(start);
                                          print(end);
                                        }).showPicker(context);
                                  },
                                  label: Text(
                                    setDateTimeText,
                                    textAlign: TextAlign.center,
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                eventStartDateText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(startTimeToShow,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF4a417f),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                eventEndDateText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(endTimeToShow,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF4a417f),
                                  )),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF4a417f),
                                  ),
                                  onPressed: disable
                                      ? null
                                      : () {
                                          submit(context);
                                        },
                                  icon: const Icon(Icons.add),
                                  label: const Text(
                                    "Submit",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF4a417f),
                                  ),
                                  onPressed: disable ? null : () {},
                                  icon: const Icon(Icons.add),
                                  label: const Text(
                                    "Submit and Add Another",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ))
                            ],
                          ))
                    ],
                  ))))
        ]));
  }
}

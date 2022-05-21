import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLng = [
    LatLng(29.85468242594262, 77.8911575764714),
    LatLng(29.86521013761661, 77.89636613290226),
    LatLng(29.865418589993528, 77.90254676094371),
    LatLng(29.872303326728456, 77.90015423043177),
    LatLng(29.871949800454086, 77.8950650320087),
    LatLng(29.86891790316885, 77.8900796678784)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }
  String sar = '';
  loadData() {
    for (int i = 0; i < _latLng.length; i++) {
      if(i==0 || i == 3)
      sar = 'Parking Space Not Available';
      else
      sar = 'Parking Space Available';

      if(i == 1 ){
        _markers.add(Marker(
            markerId: MarkerId('2'),
            position: LatLng(29.86521013761661, 77.89636613290226),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "I am here",
                                style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    // Triangle.isosceles(
                    //   edge: Edge.BOTTOM,
                    //   child: Container(
                    //     color: Colors.blue,
                    //     width: 20.0,
                    //     height: 10.0,
                    //   ),
                    // ),
                  ],
                ),
                _latLng[i],
              );
            }
        ));
      }else {
        _markers.add( Marker(
            markerId: MarkerId(i.toString()),
            position: _latLng[i],
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                  Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage('https://imgk.timesnownews.com/media/Angled_parking_spot_use.jpg'),
                                fit: BoxFit.fitWidth,
                                filterQuality: FilterQuality.high),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            color: Colors.red,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10 , left: 10 , right: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'Parking Lot',
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '.3 mi.',
                                // widget.data!.date!,

                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10 , left: 10 , right: 10),
                          child: Text(
                            sar,
                            maxLines: 2,

                          ),
                        ),

                      ],
                    ),
                  ),
                _latLng[i]
              );
            }
        ));
      }

      setState(() {

      });
    }



  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Info Window Example'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(zoom: 15, target: LatLng(29.86521013761661, 77.89636613290226)),
            markers: Set<Marker>.of(_markers),
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position){
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          )
        ],
      ),
    );
  }
}

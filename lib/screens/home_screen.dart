import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/patient_widget.dart';
import 'details_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    AppCubit.get(context).getAllPatient();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child:cubit.getAllPatientModel!.data!.data!.isEmpty ?
             const Center(
                child: Text("No Patient Founded ! "),
              ) :
          ListView.separated(
            itemCount:   cubit.getAllPatientModel!.data!.data!.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index){
              return   InkWell(
                onTap: ()async{

                  Navigator.push(
                      context, PageTransition(
                      duration: const Duration(milliseconds: 400),
                      reverseDuration: const Duration(milliseconds: 400),
                      type: PageTransitionType.rightToLeft,
                      child:     DetailsScreen(
                        name: "${cubit.getAllPatientModel!.data!.data![index].name}",
                        dataOfBirth: "${cubit.getAllPatientModel!.data!.data![index].dateOfBirth}",
                        diagnosis:"${cubit.getAllPatientModel!.data!.data![index].diagnosis}",
                        address: "${cubit.getAllPatientModel!.data!.data![index].address}",
                        visitTime: "${cubit.getAllPatientModel!.data!.data![index].visitTime}",
                      ),
                      inheritTheme: true,
                      ctx: context));
                },
                child:  CustomPatientWidget(
                    name: "${cubit.getAllPatientModel!.data!.data![index].name}",
                    dataOfBirth: "${cubit.getAllPatientModel!.data!.data![index].dateOfBirth}",
                    diagnosis:"${cubit.getAllPatientModel!.data!.data![index].diagnosis}",
                    address: "${cubit.getAllPatientModel!.data!.data![index].address}",
                    visitTime: "${cubit.getAllPatientModel!.data!.data![index].visitTime}",
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 15,);
            },),
        );
      },

    );
  }
}

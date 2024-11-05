import 'package:zohbi_user/common/models/api_response_model.dart';
import 'package:zohbi_user/common/models/brand_model.dart';
import 'package:zohbi_user/common/reposotories/brand_repo.dart';
import 'package:zohbi_user/helper/api_checker_helper.dart';
import 'package:flutter/material.dart';

class BrandProvider extends ChangeNotifier {
  final BrandRepo brandRepo;

  BrandProvider({required this.brandRepo});

  List<BrandModel>? _brandList;
  List<BrandModel>? get brandList => _brandList;

  Future<ApiResponseModel?> getBrandList(bool reload) async {
    ApiResponseModel? apiResponse;
    if(brandList == null || reload) { 
      apiResponse = await brandRepo.getBrandList();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _brandList = [];
        apiResponse.response!.data.forEach((brand) => brandList!.add(BrandModel.fromJson(brand)));
      } else {
        ApiCheckerHelper.checkApi(apiResponse);
      }
      notifyListeners();
    }
    return apiResponse;
  }

}
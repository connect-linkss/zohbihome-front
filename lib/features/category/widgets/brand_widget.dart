import 'package:zohbi_user/common/widgets/title_widget.dart';
import 'package:zohbi_user/features/home/widgets/categories_web_widget.dart';
import 'package:zohbi_user/features/home/widgets/category_shimmer_widget.dart';
import 'package:zohbi_user/helper/responsive_helper.dart';
import 'package:zohbi_user/localization/language_constrants.dart';
import 'package:zohbi_user/provider/brand_provider.dart';
import 'package:zohbi_user/utill/dimensions.dart';
import 'package:zohbi_user/utill/images.dart';
import 'package:zohbi_user/utill/routes.dart'; 
import 'package:zohbi_user/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<BrandProvider>(
      builder: (context, brand, child) {
        return (brand.brandList == null || (brand.brandList != null && brand.brandList!.isNotEmpty)) ? Column(
          children: [

            ResponsiveHelper.isDesktop(context) ?
            Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge,bottom: Dimensions.paddingSizeLarge),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(getTranslated('all_categories', context), style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeOverLarge)),
              ),
            ) : Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TitleWidget(
                title: getTranslated('all_categories', context),
                onTap: () {
                  Navigator.pushNamed(context, Routes.getCategoryAllRoute());
                },
              ),
            ),
            ResponsiveHelper.isDesktop(context) ? const CategoriesWebWidget() : Row(children: [
              Expanded(
                child: SizedBox(
                  height: 90,
                  child: brand.brandList != null ? brand.brandList!.isNotEmpty ? ListView.builder(
                    itemCount: brand.brandList!.length,
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                        child: InkWell(
                          onTap: () => {},
                          child: Column(children: [

                            Container( width: 65, height: 65,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(width: .5,color: Theme.of(context).dividerColor)
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(40)),
                                child: FadeInImage.assetNetwork(
                                  placeholder: Images.placeholder(context),
                                  image: '${brand.brandList![index].image}',
                                  width: 65, height: 65, fit: BoxFit.cover,
                                  imageErrorBuilder: (c,o,t)=> Image.asset(Images.placeholder(context),width: 65, height: 65, fit: BoxFit.cover,),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 60,
                              child: Center(
                                child: Text(
                                  brand.brandList![index].name!,
                                  style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),

                          ]),
                        ),
                      );
                    },
                  ) : Center(child: Text(getTranslated('no_category_available', context))) : const CategoryShimmerWidget(),
                ),
              ),
            ]),
          ],
        ) : const SizedBox();
      },
    );
  }
}


import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/src/header/refresh_indicator.dart';

import '../../easy_refresh.dart';

/// Header
abstract class Header {
  // Header容器高度
  final double extent;
  // 触发刷新高度
  final double triggerDistance;
  // 是否浮动
  final bool float;
  // 完成延时
  final Duration completeDuration;

  Header({
    this.extent = 60.0,
    this.triggerDistance = 70.0,
    this.float = false,
    this.completeDuration,
  });

  // 构造器
  Widget builder(BuildContext context, EasyRefresh easyRefresh) {
    return EasyRefreshSliverRefreshControl(
      refreshIndicatorExtent: extent,
      refreshTriggerPullDistance: triggerDistance,
      builder: contentBuilder,
      completeDuration: completeDuration,
      onRefresh: easyRefresh.onRefresh,
      enableControlFinishRefresh: easyRefresh.enableControlFinishRefresh,
      bindRefreshIndicator: (finishRefresh) {
        if (easyRefresh.controller != null) {
          easyRefresh.controller.finishRefresh = finishRefresh;
        }
      },
    );
  }

  // Header构造器
  Widget contentBuilder(
      BuildContext context,
      RefreshIndicatorMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      );
}

/// 通用Header
class CustomHeader extends Header {

  /// Header构造器
  final RefreshControlIndicatorBuilder headerBuilder;

  CustomHeader({
    extent = 60.0,
    triggerDistance = 70.0,
    float = false,
    completeDuration,
    @required this.headerBuilder,
  }) : super (
    extent: extent,
    triggerDistance: triggerDistance,
    float: float,
    completeDuration: completeDuration,
  );

  @override
  Widget contentBuilder(BuildContext context,
      RefreshIndicatorMode refreshState, double pulledExtent,
      double refreshTriggerPullDistance, double refreshIndicatorExtent) {
    return headerBuilder(context, refreshState, pulledExtent,
      refreshTriggerPullDistance, refreshIndicatorExtent);
  }
}

/// 经典Header
class ClassicalHeader extends Header{

  ClassicalHeader({
    extent = 60.0,
    triggerDistance = 70.0,
    float = false,
    completeDuration,
  }): super(
    extent: extent,
    triggerDistance: triggerDistance,
    float: float,
    completeDuration: completeDuration,
  );

  @override
  Widget contentBuilder(BuildContext context, RefreshIndicatorMode refreshState,
      double pulledExtent, double refreshTriggerPullDistance,
      double refreshIndicatorExtent) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFF000000),
    );
  }
}
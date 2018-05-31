# YTAnimation


> iOS 动画主要是指 `Core Animation` 框架, `Core Animation`是 `iOS` 和 `OS X` 平台上负责图形渲染与动画的基础框架。`Core Animation` 可以作用于动画视图或者其他可视元素，可以完成动画所需的大部分绘帧工作。`Core Animation` 系统已经进行了封装, 所以在使用的时候你只需要配置少量的动画参数（如开始点的位置和结束点的位置）即可使用 `Core Animation` 的多种动画效果。`Core Animation` 将大部分实际的绘图任务交给了图形硬件(**GPU**)来处理，图形硬件会加速图形渲染的速度。这种自动化的图形加速技术让动画拥有更高的帧率并且显示效果更加平滑，不会加重CPU的负担而影响程序的运行速度。

本文主要总结下平时常用的动画, 如: 基础动画(`CABasicAnimation`)、关键帧动画(`CAKeyframeAnimation`)、组动画(`CAAnimationGroup`)、过渡动画(`CATransition`), 最后也扩展了下, 做了进度条、贝塞尔曲线画心❤️、弹球、钉钉效果、点赞等动画,希望对大家有所帮助.
github: https://github.com/YTiOSer/YTAnimation

![Core Animation.jpeg](https://upload-images.jianshu.io/upload_images/8283020-093de79629cda42e.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 一、Core Animation类简介
1. 首先通过官方的 `Core Animation` 类图了解下各个类之间的关系. 官网链接:[Core Animation]()
![Core Animation.png](https://upload-images.jianshu.io/upload_images/8283020-0dc1b7c27713583d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
建议详细看下上图, 这里对 `CAAnimation` 的子类和相互关系及属性介绍的比较详细, 看完后会对各个动画类型有个大概的了解.

2. 接下来详细介绍下动画的各个属性及作用
- fromValue: 动画的开始值(**Any**类型, 根据动画不同可以是`CGPoint`、NSNumber等)
- toValue: 动画的结束值, 和fromValue类似
- beginTime: 动画的开始时间
- duration : 动画的持续时间 
- repeatCount : 动画的重复次数 
- fillMode: 动画的运行场景
- isRemovedOnCompletion: 完成后是否删除动画
- autoreverses: 执行的动画按照原动画返回执行 
- path：关键帧动画中的执行路径
- values: 关键帧动画中的关键点数组
- animations: 组动画中的动画数组
- delegate : 动画代理, 封装了动画的执行和结束方法
- timingFunction: 控制动画的显示节奏, 系统提供五种值选择，分别是：
1.`kCAMediaTimingFunctionDefault`( 默认，中间快)
2.`kCAMediaTimingFunctionLinear` (线性动画)
3.`kCAMediaTimingFunctionEaseIn` (先慢后快 慢进快出）
4.`kCAMediaTimingFunctionEaseOut` (先块后慢快进慢出）
5.`kCAMediaTimingFunctionEaseInEaseOut` (先慢后快再慢)
- type： 过渡动画的动画类型，系统提供了多种过渡动画, 分别是:
1: `fade` (淡出 默认) 
2: `moveIn` (覆盖原图) 
3: `push` (推出) 
4: `fade` (淡出 默认) 
5: `reveal` (底部显示出来) 
6: `cube` (立方旋转) 
7: `suck` (吸走) 
8: `oglFlip` (水平翻转 沿y轴) 
9: `ripple` (滴水效果) 
10: `curl` (卷曲翻页 向上翻页) 
11: `unCurl` (卷曲翻页返回 向下翻页) 
12: `caOpen` (相机开启) 
13: `caClose` (相机关闭) 
- subtype : 过渡动画的动画方向, 系统提供了四种,分别是:
1.`fromLeft`( 从左侧)
2.`fromRight` (从右侧)
3.`fromTop` (有上面）
4.`fromBottom` (从下面）

##  二、Core Animation的使用
#### 1. 基础动画( `CABasicAnimation` )
>基础动画主要提供了对于CALayer对象中的可变属性进行简单动画的操作。比如：位移、旋转、缩放、透明度、背景色等。 
基础动画根据 `keyPath` 来区分不同的动画,, 系统提供了多个类型,如: `transform.scale` (比例转换)、`transform.scale.x`、`transform.scale.y`、 `transform.rotation `(旋转) 、`transform.rotation.x`(绕x轴旋转)、`transform.rotation.y`(绕y轴旋转)、`transform.rotation.z`(绕z轴旋转)、`opacity` (透明度)、`margin`、`backgroundColor`(背景色)、`cornerRadius`(圆角)、`borderWidth`(边框宽)、`bounds`、`contents`、`contentsRect`、`cornerRadius`、`frame`、`hidden`、`mask`、`masksToBounds`、`shadowColor`(阴影色)、`shadowOffset`、`shadowOpacity`、`shadowOpacity`, 在使用时候, 需要根据具体的需求选择合适的.

效果图如下:
![旋转.gif](https://github.com/YTiOSer/YTAnimation/blob/master/images/%E6%97%8B%E8%BD%AC.gif)


- 位移动画
```
func positionAnimation() {

let animation = CABasicAnimation.init(keyPath: "position") //keyPath为系统提供
animation.fromValue = CGPoint.init(x: margin_ViewMidPosition, y: kScreenH / 2 - margin_Top)
animation.toValue = CGPoint.init(x: kScreenW - margin_ViewMidPosition, y: kScreenH / 2 - margin_Top)
animation.duration = 1.0
view_Body.layer.add(animation, forKey: "positionAnimation") //key自定义
}
```
- 旋转动画:
```
func rotateAnimation() {

let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
animation.toValue = NSNumber.init(value: Double.pi)
animation.duration = 0.1
animation.repeatCount = 1e100 //无限大重复次数
view_Body.layer.add(animation, forKey: "rotateAnimation")
}
```
- 缩放动画
```
func scaleAnimation() {

let animation = CABasicAnimation.init(keyPath: "transform.scale")
animation.toValue = NSNumber.init(value: 2.0)
animation.duration = 1.0
view_Body.layer.add(animation, forKey: "scaleAnimation")
}
```
- 透明度动画
```
func opacityAnimation() {

let animation = CABasicAnimation.init(keyPath: "opacity")
animation.fromValue = NSNumber.init(value: 1.0)
animation.toValue = NSNumber.init(value: 0.0)
animation.duration = 1.0
view_Body.layer.add(animation, forKey: "opacityAnimation")
}
```
- 背景色动画
```
func backgroundColorAnimation() {

let animation = CABasicAnimation.init(keyPath: "backgroundColor")
animation.toValue = UIColor.green.cgColor //因为layer层动画, 所以需要使用cgColor
animation.duration = 1.0
view_Body.layer.add(animation, forKey: "backgroundColorAnimation")
}
```

#### 2. 关键帧动画( `CAKeyframeAnimation` )
> `CAKeyframeAnimation` 和 `CABasicAnimation` 都属于`CAPropertyAnimatin` 的子类。不同的是 `CABasicAnimation` 只能从一个数值（`fromValue`）变换成另一个数值（`toValue`）,而 `CAKeyframeAnimation` 则会使用一个数组(` values `) 保存一组关键帧, 也可以给定一个路径(`path`)制作动画。 

`CAKeyframeAnimation`主要有 **三个** 重要属性: 
- values：存放关键帧(`keyframe`)的数组,动画对象会在指定的时间(`duration`)内，依次显示values数组中的每一个关键帧 .
- path：可以设置一个 `CGPathRef` 或 `CGMutablePathRef`,让层跟着路径移动. `path` 只对 `CALayer` 的 `anchorPoint` 和 `position` 起作用, 如果设置了path，那么values将被忽略. 
- keyTimes：可以为对应的关键帧指定对应的时间点,其取值范围为0到1.0, `keyTimes` 中的每一个时间值都对应 `values` 中的每一帧.当 `keyTimes` 没有设置的时候,各个关键帧的时间是根据 `duration` 平分的。

以抖动截图为例, 效果图如下:
![抖动.gif](https://github.com/YTiOSer/YTAnimation/blob/master/images/%E6%8A%96%E5%8A%A8.gif)



动画代码如下: 
- 关键帧动画
```
func keyFrameAnimation() {

let animation = CAKeyframeAnimation.init(keyPath: "position")
let value_0 = CGPoint.init(x: margin_ViewMidPosition, y: kScreenH / 2 - margin_ViewWidthHeight)
let value_1 = CGPoint.init(x: kScreenW / 3, y: kScreenH / 2 - margin_ViewWidthHeight)
let value_2 = CGPoint.init(x: kScreenW / 3, y: kScreenH / 2 + margin_ViewMidPosition)
let value_3 = CGPoint.init(x: kScreenW * 2 / 3, y: kScreenH / 2 + margin_ViewMidPosition)
let value_4 = CGPoint.init(x: kScreenW * 2 / 3, y: kScreenH / 2 - margin_ViewWidthHeight)
let value_5 = CGPoint.init(x: kScreenW - margin_ViewMidPosition, y: kScreenH / 2 - margin_ViewWidthHeight)
animation.values = [value_0, value_1, value_2, value_3, value_4, value_5]
animation.duration = 2.0
view_Body.layer.add(animation, forKey: "keyFrameAnimation")
}
```
- 路径动画
```
func pathAnimation() {

let animation = CAKeyframeAnimation.init(keyPath: "position")
let path = UIBezierPath.init(arcCenter: CGPoint.init(x: kScreenW / 2, y: kScreenH / 2), radius: 60, startAngle: 0.0, endAngle: .pi * 2, clockwise: true)
animation.duration = 2.0
animation.path = path.cgPath
view_Body.layer.add(animation, forKey: "pathAnimation")
}
```
- 抖动动画
```
func shakeAnimation() {

let animation = CAKeyframeAnimation.init(keyPath: "transform.rotation")
let value_0 = NSNumber.init(value: -Double.pi / 180 * 8)
let value_1 = NSNumber.init(value: Double.pi / 180 * 8)
animation.values = [value_0, value_1, value_0]
animation.duration = 1.0
animation.repeatCount = 1e100
view_Body.layer.add(animation, forKey: "shakeAnimation")
}
```

#### 3. 组动画( `CAAnimationGroup` )
`CAAnimationGroup` 是 `CAAnimation` 的子类，可以保存一组动画对象，可以保存基础动画、关键帧动画等，数组中所有动画对象可以同时并发运行, 也可以通过实践设置为串行连续动画.

效果截图如下:
![组动画2.gif](https://github.com/YTiOSer/YTAnimation/blob/master/images/%E7%BB%84%E5%8A%A8%E7%94%BB2.gif)


动画代码如下: 
- 同时
```
//同时
func sameTimeAnimation() {

let animation_Position = CAKeyframeAnimation.init(keyPath: "position")
let value_0 = CGPoint.init(x: margin_ViewMidPosition, y: kScreenH / 2 - margin_ViewMidPosition)
let value_1 = CGPoint.init(x: kScreenW / 3, y: kScreenH / 2 - margin_ViewMidPosition)
let value_2 = CGPoint.init(x: kScreenW / 3, y: kScreenH / 2 + margin_ViewMidPosition)
let value_3 = CGPoint.init(x: kScreenW / 3 * 2, y: kScreenH / 2 + margin_ViewMidPosition)
let value_4 = CGPoint.init(x: kScreenW / 3 * 2, y: kScreenH / 2 - margin_ViewMidPosition)
let value_5 = CGPoint.init(x: kScreenW - margin_ViewMidPosition, y: kScreenH / 2 - margin_ViewMidPosition)
animation_Position.values = [value_0, value_1, value_2, value_3, value_4, value_5]

let animation_BGColor = CABasicAnimation.init(keyPath: "backgroundColor")
animation_BGColor.toValue = UIColor.green.cgColor

let animation_Rotate = CABasicAnimation.init(keyPath: "transform.rotation")
animation_Rotate.toValue = NSNumber.init(value: Double.pi * 4)

let animation_Group = CAAnimationGroup()
animation_Group.animations = [animation_Position, animation_BGColor, animation_Rotate]
animation_Group.duration = 4.0
view_Body.layer.add(animation_Group, forKey: "groupAnimation")
}
```
- 连续
```
//连续动画 最主要的是处理好各个动画时间的衔接
func goOnAnimation() {

//定义一个动画开始的时间
let currentTime = CACurrentMediaTime()

let animation_Position = CABasicAnimation.init(keyPath: "position")
animation_Position.fromValue = CGPoint.init(x: margin_ViewMidPosition, y: kScreenH / 2)
animation_Position.toValue = CGPoint.init(x: kScreenW / 2, y: kScreenH / 2)
animation_Position.duration = 1.0
animation_Position.fillMode = "forwards" //只在前台
animation_Position.isRemovedOnCompletion = false //切出界面再回来动画不会停止
animation_Position.beginTime = currentTime
view_Body.layer.add(animation_Position, forKey: "positionAnimation")

let animation_Scale = CABasicAnimation.init(keyPath: "transform.scale")
animation_Scale.fromValue = NSNumber.init(value: 0.7)
animation_Scale.toValue = NSNumber.init(value: 2.0)
animation_Scale.duration = 1.0
animation_Scale.fillMode = "forwards"
animation_Scale.isRemovedOnCompletion = false
animation_Scale.beginTime = currentTime + 1.0
view_Body.layer.add(animation_Scale, forKey: "scaleAnimation")

let animation_Rotate = CABasicAnimation.init(keyPath: "transform.rotation")
animation_Rotate.toValue = NSNumber.init(value: Double.pi * 4)
animation_Rotate.duration = 1.0
animation_Rotate.fillMode = "forwards"
animation_Rotate.isRemovedOnCompletion = false
animation_Rotate.beginTime = currentTime + 2.0
view_Body.layer.add(animation_Rotate, forKey: "rotateAnimation")
}
```

#### 4. 过渡动画( `CATransition` )
`CATransition` 是 `CAAnimation` 的子类，用于做过渡动画或者 **转场** 动画，能够为层提供移出屏幕和移入屏幕的动画效果。

过渡动画通过 ` type` 设置不同的动画效果, `CATransition` 有多种过渡效果, 但其实 `Apple` 官方的SDK只提供了**四**种:
- fade 淡出 默认
- moveIn 覆盖原图
- push 推出
- reveal 底部显示出来

但**私有API**提供了其他很多非常炫的过渡动画，如 `cube`(立方旋转)、`suckEffect`(吸走)、`oglFlip`(水平翻转 沿y轴)、 `rippleEffect`(滴水效果)、`pageCurl`(卷曲翻页 向上翻页)、`pageUnCurl`(卷曲翻页 向下翻页)、`cameraIrisHollowOpen`(相机开启)、`cameraIrisHollowClose`(相机关闭)等。 

**注**:  因 `Apple` 不提供维护，并且有可能造成你的app审核不通过, 所以不建议开发者们使用这些私有API.

效果如下:
![过渡动画.gif](https://github.com/YTiOSer/YTAnimation/blob/master/images/%E8%BF%87%E6%B8%A1%E5%8A%A8%E7%94%BB.gif)

翻页动画代码如下:
```
func curlAnimation() {

let animation_Curl = CATransition()
animation_Curl.type = "pageCurl"
animation_Curl.subtype = "fromRight"
animation_Curl.duration = 1.0
view_Body.layer.add(animation_Curl, forKey: "curlAnimation")
}
```

#### 5. 项目案例
1. 进度条
效果如下:
![进度条.gif](https://github.com/YTiOSer/YTAnimation/blob/master/images/%E8%BF%9B%E5%BA%A6%E6%9D%A1.gif)
这里主要用到了 `CAShapeLayer` + ` CAGradientLayer`, 使用 `CAGradientLayer` 画进度圈(GPU执行, 高效), 然后使用 `CAGradientLayer`  渐变色layer, 结合动画显示进度条.
代码如下:
- UI视图
```
func createView() {

label_Progress = UILabel()
label_Progress.text = ""
label_Progress.textAlignment = .center
label_Progress.font = UIFont.systemFont(ofSize: 25)
addSubview(label_Progress)
label_Progress.snp.makeConstraints { (make) in
make.centerX.centerY.equalTo(self)
make.width.equalTo(kScreenW)
make.height.equalTo(30)
}

layer_BackPath = CAShapeLayer()
layer_BackPath.fillColor = UIColor.clear.cgColor //填充颜色
layer_BackPath.strokeColor = UIColor.white.withAlphaComponent(0.5).cgColor //划线颜色
layer_BackPath.lineWidth = width_MainPath
layer.addSublayer(layer_BackPath)

layer_MainPathLayer = CAShapeLayer()
layer_MainPathLayer.fillColor = UIColor.clear.cgColor
layer_MainPathLayer.strokeColor = UIColor.white.cgColor
layer_MainPathLayer.lineWidth = width_MainPath
layer.addSublayer(layer_MainPathLayer)

//渐变色
layer_Gradient = CAGradientLayer()
layer_Gradient.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH)
layer_Gradient.type = "axial" //线性变化  默认目前只有这一个type
layer_Gradient.colors = [UIColor.init(hex: 0xf31414).cgColor, UIColor.init(hex: 0xf27200).cgColor, UIColor.init(hex: 0xffff00).cgColor, UIColor.init(hex: 0x2bee22).cgColor, UIColor.init(hex: 0x32a7eb).cgColor]
layer_Gradient.locations = [0, 0.3, 0.5, 0.7, 1] //每个渐变颜色的终止位置，这些值必须是递增的，数组的长度和colors的长度最好一致
//startPoint endPoint 分别表示渐变层的起始位置和终止位置，这两个点被定义在一个单元坐标空间，[0,0]表示左上角位置，[1,1]表示右下角位置，默认值分别是[.5,0] and [.5,1]；
layer_Gradient.startPoint = CGPoint.init(x: 0, y: 0)
layer_Gradient.endPoint = CGPoint.init(x: 1, y: 0)
layer.addSublayer(layer_Gradient)

}
```
- 进度
```
func drawCircle(){

//贝塞尔曲线画圆
let path_Back = UIBezierPath.init(arcCenter: CGPoint.init(x: kScreenW / 2, y: kScreenH / 2), radius: kScreenW / 5 - width_MainPath, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3, clockwise: true)
let path_Main = UIBezierPath.init(arcCenter: CGPoint.init(x: kScreenW / 2, y: kScreenH / 2), radius: kScreenW / 5 - width_MainPath + 3, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3, clockwise: true)

layer_BackPath.path = path_Back.cgPath
layer_MainPathLayer.path = path_Main.cgPath

layer_Gradient.mask = layer_MainPathLayer //用 layer_MainPathLayer 截取渐变层

//动画 显示路径
let animation = CABasicAnimation.init(keyPath: "strokeEnd")
animation.duration = CFTimeInterval(Double(progress) * 0.01)
animation.fromValue = NSNumber.init(value: 0)
animation.toValue = NSNumber.init(value: Double(progress) * 0.01)
animation.fillMode = "forwards"
animation.isRemovedOnCompletion = false //完成后不删除动画
layer_MainPathLayer.add(animation, forKey: "strokeEndAnimation")

if progress > 0{
DispatchQueue.global().async {
self.timer_ProgressLabel = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(YTProgressView.progressLabelTimerAction), userInfo: nil, repeats: true)
RunLoop.current.run()
}
}else{
label_Progress.text = "0%"
}

}

func progressLabelTimerAction() {

DispatchQueue.main.async {
self.label_Progress.text = String(self.num_Progress) + "%"
}

if num_Progress >= progress{ //销毁计时器
timer_ProgressLabel.invalidate()
timer_ProgressLabel = nil
}else{
num_Progress += 1
}

}
```
这里只展示了核心代码, 详细代码可到github下载完整代码: https://github.com/YTiOSer/YTAnimation

2. 弹球, 仿Path菜单效果

- 点击红色按钮，红色按钮旋转。（**旋转动画**） 
- 黑色小按钮依次弹出，并且带有旋转效果。（**位移动画、旋转动画、组动画**） 
- 点击黑色小按钮，其他按钮消失，被点击的黑色按钮变大变淡消失。（**缩放动画、alpha动画、组动画**） 
![tanqiu.gif](https://github.com/YTiOSer/YTAnimation/blob/master/images/tanqiu.gif)


3. 仿钉钉菜单效果

![dingding.png](https://upload-images.jianshu.io/upload_images/8283020-64acf2267a54e205.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

动画实现用到了位移动画和缩放动画, 其实不难.

4. 点赞
![点赞.gif](https://github.com/YTiOSer/YTAnimation/blob/master/images/%E7%82%B9%E8%B5%9E.gif)

## 三、总结
看完整篇文章相信你对  iOS` 中的动画有了一个详细的了解, 其实单个动画都是比较简单的, 而复杂的动画其实都是由一个个简单的动画组装而成的，所以遇到比较难得动画需求, 我们只要充分组装不同的动画，就能实现出满意的效果.

好记性不如烂笔头, 光说不练假把戏, 建议大家结合我的代码, 自己边看边练习, 这样才能记得牢, 才能转换成自己的知识. 

github: https://github.com/YTiOSer/YTAnimation
如果觉得对你还有些用，给一颗star吧。你的支持是我继续的动力。

简书：https://www.jianshu.com/u/562ebc94345f 























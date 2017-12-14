# CocoaPodTest
#### [How to add license to an existing GitHub project](https://stackoverflow.com/questions/31639059/how-to-add-license-to-an-existing-github-project)

## 发布cocoapods 开源库
* #### 上传代码，并打上 `tag`
* #### 注册CocoaPods
        `truck` 需要将 pod 升级到最新版本
        `pod trunk me` 查看自己是否已经注册过
        如未注册 执行`pod trunk register 邮箱 用户名 --verbose`
        注册完成之后会给你的邮箱发个邮件，进入邮箱邮件里面有个链接，需要点击确认一下。注册完成后使用`pod trunk me`检验注册是否成功
    ! [Image](podtrunkme.png)
* #### 创建 .podspec
    到项目的根目录，执行命令`pod spec create 项目名称`
    【注意】: 项目名称不能和 github 上已存在的项目名称重复
* #### 编辑 .podspec
s.name：名称，pod search搜索的关键词,注意这里一定要和.podspec的名称一样,否则报错
`s.version`:版本号，to_s：返回一个字符串
`s.author`:作者
`s.homepage`:项目主页地址
`s.summary`: 项目简介
`s.source`:项目源码所在地址
`s.license`:许可证
这里建议这样写,如果写别的会报警告,导致后面一直提交失败。

`s.platform`:项目支持平台
`s.requires_arc`: 是否支持ARC
`s.source_files`:需要包含的源文件
*表示匹配所有文件
*.{h,m}表示匹配所有以.h和.m结尾的文件
**表示匹配所有子目录
`s.public_header_files`:需要包含的头文件
`s.ios.deployment_target`:支持的pod最低版本
其他一些非必要字段
`s.social_media_url`: 社交网站
`s.resources`:资源文件
`s.dependency`:依赖库,不能依赖未发布的库

* #### 验证 .podspec
验证 .podsepc 文件是否存在语法错误 执行命令`pod spec lint 项目名称.podspec --verbose`

* #### 验证通过之后，发布
执行命令`pod trunk push 项目名称.podspec`

* #### 测试cocoapods
这个时候使用`pod search`搜索的话会提示搜索不到，可以执行以下命令更新本地`search_index.json`文件
执行命令`rm ~/Library/Caches/CocoaPods/search_index.json`,清除pod缓存

如果还是搜索不到，执行命令`pod setup`


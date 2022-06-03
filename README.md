Demonstrates docc failing to build documentation for a framework in a workspace generated using cocoapods. The workspace is already generated, so running the following in the root of this project should result in a failure. 

Tested on Xcode 13.4.

```
xcodebuild build -scheme Core \
    -workspace docc-fail.xcworkspace \
    -destination generic/platform=iOS

xcodebuild docbuild -scheme Core \
    -workspace docc-fail.xcworkspace \
    -destination generic/platform=iOS \
    OTHER_DOCC_FLAGS="--transform-for-static-hosting --output-path ../docs --hosting-base-path docs"
```

import ProjectDescription
import ProjectDescriptionHelpers

let projectName = "MiniProject"
let project = Project(
    name: projectName,
    targets: [
        Target(
            name: projectName,
            platform: .iOS,
            product: .app,
            bundleId: "com.dahyechoi.\(projectName)",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone]),
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleShortVersionString": "1.0",
                    "CFBundleVersion": "1",
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen"
                ]
            ),
            sources: ["\(projectName)/Sources/**"],
            resources: ["\(projectName)/Resources/**"]
        )
    ],
    resourceSynthesizers: [
        .fonts(),
        .assets()
    ]
)

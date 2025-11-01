import { Camera, EnvironmentBackgroundType, Scene } from "@kit.ArkGraphics3D"
import { AnimatorOptions, AnimatorResult } from "@ohos.animator";

@Builder
export function DigitsDemoBuilder(name: string, param: Object) {
  Subpage()
}

@ComponentV2
struct Subpage {
  scene: Scene | null = null;
  cam: Camera | null = null;
  @Local sceneOpt: SceneOptions | null = null;
  animator: AnimatorResult | null = null;
  @Local userInput: string = "";

  build() {
    NavDestination() {
      if (this.sceneOpt == null) {
        Text("Loading Digits...")
      } else {
        Stack() {
          Component3D(
            this.sceneOpt
          )

          TextInput({
            text: this.userInput!!
          }).onChange((value: string) => {
            console.log(value.charAt(0))
            let root = this.scene?.getNodeByPath("rootNode_/Scene")
            if (root == null) {
              return
            }
            let childrenCount = root?.children.count() ?? 0
            for (let i = 0; i < childrenCount; i++) {
              let child = root?.children.get(i)
              console.log(child?.name + "(Node");
              if (child == null) {
                continue
              }
              child.visible = child.name.charAt(2) == value.charAt(0);
            }
          })
        }
      }
    }
    .title('3D节点控制')
    .width("100%")
    .height("100%")
  }

  onDidBuild(): void {
    this.Init();
    this.animator?.play()
  }

  Init() {
    if (this.sceneOpt != null) {
      return;
    }
    Scene.load($rawfile('Digits.glb')).then(
      async (result: Scene) => {
        this.scene = result;

        let rf = this.scene.getResourceFactory();
        this.cam = await rf.createCamera({ "name": "Camera" });
        this.cam.enabled = true;
        this.cam.position = { x: 0, y: 0, z: 4 };
        this.cam.nearPlane = 0.1;
        this.cam.farPlane = 5;
        this.scene.environment.backgroundType = EnvironmentBackgroundType.BACKGROUND_NONE;
        this.cam.clearColor = {
          r: 1,
          g: 1,
          b: 1,
          a: 0
        }
        this.sceneOpt = {
          scene: this.scene,
          modelType: ModelType.SURFACE
        } as SceneOptions;
        console.info("Loaded.")

      }
    ).catch((error: Error) => {
      console.error('Scene load failed:', error);
    })
  }
}
import { Camera, EnvironmentBackgroundType, Scene } from "@kit.ArkGraphics3D"
import { AnimatorOptions, AnimatorResult } from "@ohos.animator";

@Builder
export function BasicComponent3DBuilder(name: string, param: Object) {
  Subpage()
}

@ComponentV2
struct Subpage {
  sceneFront: Scene | null = null;
  camFront: Camera | null = null;
  @Local sceneOptFront: SceneOptions | null = null;
  @Local sceneOptBack: SceneOptions | null = null;
  animator: AnimatorResult | null = null;

  build() {
    NavDestination() {
      if (this.sceneOptFront == null) {
        Text("Loading Helmet...")
      } else {
        Stack() {
          Component3D(
            this.sceneOptFront
          )
          Text("Lorem ipsum")
            .alignSelf(ItemAlign.Center)
            .backgroundColor("#44556699")
            .fontSize("128px")
            .padding("32px")
            .borderRadius("24px")

        }
      }
    }
    .title('基础3D模型显示')
    .width("100%")
    .height("100%")
  }

  onDidBuild(): void {
    this.Init();
    this.animator?.play()
  }



  Init() {
    if (this.sceneOptFront != null) {
      return;
    }
    Scene.load($rawfile('DamagedHelmet.glb')).then(
      async (result: Scene) => {
        this.sceneFront = result;

        let rf = this.sceneFront.getResourceFactory();
        this.camFront = await rf.createCamera({ "name": "Camera" });
        this.camFront.enabled = true;
        this.camFront.position = { x: 0, y: 0, z: 4 };
        this.camFront.nearPlane = 0.1;
        this.camFront.farPlane = 5;
        console.log(this.sceneFront.root?.name)
        this.sceneFront.environment.backgroundType = EnvironmentBackgroundType.BACKGROUND_NONE;
        this.camFront.clearColor = {
          r: 1,
          g: 1,
          b: 1,
          a: 0
        }
        this.sceneOptFront = {
          scene: this.sceneFront,
          modelType: ModelType.SURFACE
        } as SceneOptions;
        console.info("Loaded.")
        this.animator = this.getUIContext().createAnimator({
          duration: 2000,
          fill: "both",
          begin: 0,
          end: 1,
          iterations: -1,
          easing: "linear",
          delay: 0,
          direction: "alternate"
        })
        this.animator.onFrame = (x: number) => {
          if (this.camFront != null) {
            this.camFront.position.z = x * 2 + 4
            // Math.max(x * 5 + 3, this.cam.nearPlane);
            console.log(this.camFront.farPlane.toString())
          }
        }
        this.animator.play()

      }
    ).catch((error: Error) => {
      console.error('Scene load failed:', error);
    })
  }
}
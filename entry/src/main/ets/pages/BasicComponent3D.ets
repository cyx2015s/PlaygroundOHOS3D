import { Camera, EnvironmentBackgroundType, Scene } from "@kit.ArkGraphics3D"
import { AnimatorOptions, AnimatorResult } from "@ohos.animator";

@Builder
export function BasicComponent3DBuilder(name: string, param: Object) {
  Subpage()
}

@ComponentV2
struct Subpage {
  scene: Scene | null = null;
  cam: Camera | null = null;
  @Local sceneOpt: SceneOptions | null = null;
  animator: AnimatorResult | null = null;

  build() {
    NavDestination() {
      if (this.sceneOpt == null) {
        Text("Loading Helmet...")
      } else {
        Component3D(
          this.sceneOpt
        )
      }
    }
    .title('基础3D模型显示')
    .width("100%")
    .height("100%")
  }

  onDidBuild(): void {
    this.Init();
  }

  Init() {
    if (this.sceneOpt != null) {
      return;
    }
    Scene.load($rawfile('DamagedHelmet.glb')).then(
      async (result: Scene) => {
        this.scene = result;
        let rf = this.scene.getResourceFactory();
        this.cam = await rf.createCamera({ "name": "Camera" });
        this.cam.enabled = true;
        this.cam.position = { x: 0, y: 0, z: 4 };
        this.cam.nearPlane = 0.1;
        this.cam.farPlane = 100;
        console.log(this.scene.root?.name)
        this.scene.environment.backgroundType = EnvironmentBackgroundType.BACKGROUND_NONE;
        this.cam.clearColor = {
          r: 1,
          g: 1,
          b: 1,
          a: 1
        }
        this.sceneOpt = {
          scene: this.scene,
          modelType: ModelType.SURFACE
        } as SceneOptions;
        console.info("Loaded.")
        this.animator = this.getUIContext().createAnimator({
          duration: 5000,
          fill: "both",
          begin: 0,
          end: 1,
          iterations: -1,
          easing: "linear",
          delay: 0,
          direction: "alternate"
        })
        this.animator.onFrame = (x: number) => {
          if (this.cam != null) {
            this.cam.farPlane = Math.max(x * 5 + 3, this.cam.nearPlane);
            console.log(this.cam.farPlane.toString())
          }
        }
        this.animator.play()

      }
    ).catch((error: Error) => {
      console.error('Scene load failed:', error);
    })
  }
}
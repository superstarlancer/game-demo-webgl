/**
	"Main" class takes care of all the top-level stuff in the whole application. Any other Process should be a child of Main.
**/

class Main extends dn.Process {
	public static var ME : Main;

	/** 2D scene **/
	public var scene(default,null) : h2d.Scene;

	/** Used to create "Access" instances that allow controller checks (keyboard or gamepad) **/
	public var controller : dn.heaps.Controller;

	/** Controller Access created for Main & Boot **/
	public var ca : dn.heaps.Controller.ControllerAccess;

	public function new(s:h2d.Scene) {
		super();
		ME = this;
		scene = s;
        createRoot(scene);

		initEngine();
		initComponents();
		initController();

		// Optional screen that shows a "Click to start/continue" message when the game client looses focus
		#if js
		new dn.heaps.GameFocusHelper(scene, Assets.fontMedium);
		#end

		startGame();
	}


	function initEngine() {
		// Engine settings
		engine.backgroundColor = 0xff<<24 | 0x111133;
        #if( hl && !debug )
        engine.fullScreen = true;
        #end

		// Heaps resource management
		#if( hl && debug )
			hxd.Res.initLocal();
			hxd.res.Resource.LIVE_UPDATE = true;
        #else
      		hxd.Res.initEmbed();
        #end

		// Sound manager (force manager init on startup to avoid a freeze on first sound playback)
		hxd.snd.Manager.get();

		// Apply framerates
		hxd.Timer.smoothFactor = 0;
		hxd.Timer.wantedFPS = Const.FPS;
		dn.Process.FIXED_UPDATE_FPS = Const.FIXED_UPDATE_FPS;
	}

	public inline function exists() return ME!=null && !ME.destroyed;

	/** Close the app **/
	public function exit() {
		destroy();
	}

	override function onDispose() {
		super.onDispose();

		#if hl
		hxd.System.exit();
		#end
	}


	function initComponents() {
		// Init game assets
		Assets.init();

		// Init console (open with [²] key)
		new ui.Console(Assets.fontTiny, scene); // init debug console

		// Init lang data
		Lang.init("en");
	}


	/** Game controller & default key bindings **/
	function initController() {
		controller = new dn.heaps.Controller(scene);
		ca = controller.createAccess("main");
		controller.bind(AXIS_LEFT_X_NEG, K.LEFT, K.Q, K.A);
		controller.bind(AXIS_LEFT_X_POS, K.RIGHT, K.D);
		controller.bind(X, K.SPACE, K.F, K.E);
		controller.bind(A, K.UP, K.Z, K.W);
		controller.bind(B, K.ENTER, K.NUMPAD_ENTER);
		controller.bind(SELECT, K.R);
		controller.bind(START, K.N);
	}




	/** Start game process **/
	public function startGame() {
		if( Game.exists() ) {
			Game.ME.destroy();
			dn.Process.updateAll(1); // ensure all garbage collection is done
			new Game();
			hxd.Timer.skip();
		}
		else {
			hxd.Timer.skip(); // need to ignore heavy Sound manager init frame
			delayer.addF( ()->{
				new Game();
				hxd.Timer.skip();
			}, 1 );
		}
	}


    override function update() {
		Assets.tiles.tmod = tmod;
        super.update();
    }
}
package ui;

class Modal extends ui.Window {
	public static var ALL : Array<Modal> = [];
	static var COUNT = 0;

	var ca : ControllerAccess<GameAction>;
	var mask : h2d.Flow;
	var modalIdx : Int;

	public function new(?p) {
		super(p);

		ALL.push(this);
		modalIdx = COUNT++;
		if( modalIdx==0 )
			Game.ME.pause();

		ca = App.ME.controller.createAccess();
		ca.takeExclusivity();
		ca.lockCondition = ()->App.ME.anyInputHasFocus();
		mask = new h2d.Flow(root);
		mask.backgroundTile = h2d.Tile.fromColor(0x0, 1, 1, 0.6);
		root.under(mask);
		dn.Process.resizeAll();
	}

	public static function hasAny() {
		for(e in ALL)
			if( !e.destroyed )
				return true;
		return false;
	}

	override function onDispose() {
		super.onDispose();
		ca.dispose();
		ALL.remove(this);
		COUNT--;
		if( !hasAny() )
			Game.ME.resume();
	}

	function closeAllModals() {
		for(e in ALL)
			if( !e.destroyed )
				e.close();
	}

	override function onResize() {
		super.onResize();
		if( mask!=null ) {
			var w = M.ceil( w()/Const.UI_SCALE );
			var h = M.ceil( h()/Const.UI_SCALE );
			mask.minWidth = w;
			mask.minHeight = h;
		}
	}

	override function postUpdate() {
		super.postUpdate();
		mask.visible = modalIdx==0;
		win.alpha = modalIdx==COUNT-1 ? 1 : 0.6;
	}

	override function update() {
		super.update();
		if( ca.isPressed(MenuCancel) )
			close();
	}
}

module 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point {
    struct POINT has drop {
        dummy_field: bool,
    }

    struct PointManager has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<POINT>,
    }

    public fun admin_mint_points(arg0: &0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::admin::AdminCap, arg1: &mut PointManager, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POINT>>(mint_points(arg1, arg2, arg4), arg3);
    }

    public(friend) fun burn_points(arg0: &mut PointManager, arg1: 0x2::coin::Coin<POINT>) {
        0x2::coin::burn<POINT>(&mut arg0.treasury, arg1);
    }

    fun init(arg0: POINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POINT>(arg0, 0, b"POINT", b"Alphabets Point", b"In-game point for Alphabets", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = PointManager{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::share_object<PointManager>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POINT>>(v1);
    }

    public(friend) fun mint_points(arg0: &mut PointManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<POINT> {
        0x2::coin::mint<POINT>(&mut arg0.treasury, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}


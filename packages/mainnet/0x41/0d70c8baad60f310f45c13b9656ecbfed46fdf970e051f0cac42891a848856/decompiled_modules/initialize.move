module 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::initialize {
    struct InitCap has store, key {
        id: 0x2::object::UID,
    }

    struct INITIALIZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: INITIALIZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::upgrade_service::new<INITIALIZE>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::upgrade_service::UpgradeService<INITIALIZE>>(v0);
        let v2 = InitCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<InitCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun init_state(arg0: InitCap, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::share_state(0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::new(arg1, 0x2::tx_context::sender(arg2), arg2));
        let InitCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}


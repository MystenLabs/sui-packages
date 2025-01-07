module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::initialize {
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

    public fun init_state(arg0: InitCap, arg1: u32, arg2: u32, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::new(arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg5);
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::attester_manager::enable_attester_internal(arg4, &mut v0, arg5);
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::share_state(v0);
        let InitCap { id: v1 } = arg0;
        0x2::object::delete(v1);
    }

    // decompiled from Move bytecode v6
}


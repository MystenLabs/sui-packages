module 0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v7
}


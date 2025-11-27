module 0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xaee66d8555b18e3229269d273c0bdb58a86a879434b36ac1527491bc27def5db::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xaee66d8555b18e3229269d273c0bdb58a86a879434b36ac1527491bc27def5db::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}


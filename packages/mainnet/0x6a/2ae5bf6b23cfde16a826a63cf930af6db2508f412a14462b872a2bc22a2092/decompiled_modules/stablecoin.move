module 0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x7e262a680b092cb43aa5851b591495ebc4646f11892748e8694d4b5e3e9a374d::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x7e262a680b092cb43aa5851b591495ebc4646f11892748e8694d4b5e3e9a374d::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}


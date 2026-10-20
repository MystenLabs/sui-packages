module 0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v7
}


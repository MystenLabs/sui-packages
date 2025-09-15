module 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}


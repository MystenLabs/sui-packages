module 0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}


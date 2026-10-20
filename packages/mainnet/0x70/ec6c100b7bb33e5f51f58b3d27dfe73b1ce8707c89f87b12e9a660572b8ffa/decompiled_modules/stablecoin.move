module 0x70ec6c100b7bb33e5f51f58b3d27dfe73b1ce8707c89f87b12e9a660572b8ffa::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x70ec6c100b7bb33e5f51f58b3d27dfe73b1ce8707c89f87b12e9a660572b8ffa::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x70ec6c100b7bb33e5f51f58b3d27dfe73b1ce8707c89f87b12e9a660572b8ffa::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v7
}


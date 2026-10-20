module 0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v7
}


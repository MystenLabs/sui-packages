module 0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xc603569af67780546547523632e88c0840c9b09b12bc4c25f844a419b9645624::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xc603569af67780546547523632e88c0840c9b09b12bc4c25f844a419b9645624::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}


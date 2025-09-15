module 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}


module 0x5d0305f1656a67250d1d3152e4df746cffd82c35049735bb4a4e6a25878878d6::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCap<TT>>(0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ef606176fb5e6f4d060ab112fb58ae6a4d6845d77119961c1346fb5fa6682a73213878628ae09ced02429f0b326edd7fb3243c4b4423c5b06d68888c260f21055df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747903911"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


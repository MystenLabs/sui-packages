module 0x8c22d1cad53785b9f2386ec7f6e661d049ae96c7c1bb30d6d49de5d60c019ac1::tt4 {
    struct TT4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT4, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCap<TT4>>(0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve<TT4>(arg0, b"TT4", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001b97c40ad59ef40f0997c2e5d6f320a302e35d90fb180a3584936d9f69f038b26d728dbafabb0be9f63056173b8204f7751782f607778c1f4ccd727d108760025df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747904414"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


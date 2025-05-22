module 0xc4ef05b9dd817feb2059f880373271e62e582d5c0390bd44f2bb0e17fc447eef::tt156 {
    struct TT156 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT156, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve_v2<TT156>(arg0, b"TT156", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000c9d7e77af0d383a2fd9afaff78d575ccb3058388b96ced2abbdc0a2d9e4130842044d779ca2a2861713ee5592555827e202b7a097ef5f445a88717ce795a8095df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747907861"), arg1);
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT156>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


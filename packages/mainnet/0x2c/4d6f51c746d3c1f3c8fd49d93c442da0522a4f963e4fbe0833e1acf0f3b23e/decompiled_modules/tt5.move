module 0x2c4d6f51c746d3c1f3c8fd49d93c442da0522a4f963e4fbe0833e1acf0f3b23e::tt5 {
    struct TT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT5, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCap<TT5>>(0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve<TT5>(arg0, b"TT5", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005d65604078796500bf321fbc9c2ca896a01390374e955c5351bbaed00f88ef2ca9e7cc4e68157eea2f0d3758730d1941d58ea66153646142f41609a5be8c0c035df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747904662"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


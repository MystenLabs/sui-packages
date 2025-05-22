module 0x3bad3303a28f598f94a16b9e2558129180a43806b6e10d35abb0b3530f3dc5c::rr123 {
    struct RR123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR123, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCap<RR123>>(0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve<RR123>(arg0, b"RR123", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005b64aaf1ee9c1003c4c68a42320ae3ccddd06987c19c56e813d2f77b2f78149f381405ab69ef06b7531d047ef9e1bf3304d43cb8b632122307ee8ba9869ea2005df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747904958"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


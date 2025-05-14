module 0x513664abf71e0517d81ce2075049e9243efeb574562115d6b98b643744b76b7c::netst3 {
    struct NETST3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETST3, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NETST3>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NETST3>(arg0, b"NETST3", b"Netest", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007c4a91fc9a9e933934e5d2d8adcd630b52669bf7135b5cd3f31b274c5ac3e6a79a214738737232efbad56fb6054e61f49ff2743da53b961c0307c259bc527b06d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747232005"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


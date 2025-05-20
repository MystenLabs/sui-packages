module 0x385b4d84fdeafe74223d2a544e2dc56189073756b5538b528d1415f000bc619b::mewo {
    struct MEWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MEWO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MEWO>(arg0, b"Mewo", b"Mewo Mewo", b"Mewo Mewo Mewo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVzrRQFwboD1NtrKFndZabZHgEu9D9ByHHWE3znyKjCdu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00cf6a1dd9718d0a54b898c052d3c5a360170785817f6b4d9fbd8c196011fda881c6932f65487d6b6467af367fe9ff71d60882f607136e5fdac70f4dea5a2b060ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747772818"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xe9561981884bf2de2ea70d6f9d8ab3d4a20aa4b2a4e1ad8f2090a146e13b2d10::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SC>(arg0, b"SC", b"Splashy the cat", b"Splashy the first cat on splashy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPhebU7BNv8xgB5Q6o5TJ3LkyJVWT8z3rSHcmtxpPWFWR")), b"WEBSITE", b"https://x.com/splashycat_sui", b"DISCORD", b"t.me/splaschycat", 0x1::string::utf8(b"00a822928849df1590760fdd1dbb6ad0b32f878a1909ea0bfb4f583a214d5cffd9f8a4c087b4e04051a5164b59c482d7e8c2dd49bc6b5269c747e6325927dcc204d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747846539"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x764527f495df147f270eb9abec849d63d5429c123b2096866e37d7d2545024fa::hrw {
    struct HRW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HRW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HRW>(arg0, b"HRW", b"HARAW", b"clope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcBSNNTMyF5q89wxmpBiYmf1oNKd8rxBxbdQk3VQKed3P")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005dd91093146b998d967f3b18a7b8d3b7359976f4498254b699e19dc78a9fa7d844b4b4b80d9cd9449309032e930cf0a207e3c2bfdaa9a7d05362fb279af33900d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756586"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


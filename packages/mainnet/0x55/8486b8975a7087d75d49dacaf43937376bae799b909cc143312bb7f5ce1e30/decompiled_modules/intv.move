module 0x558486b8975a7087d75d49dacaf43937376bae799b909cc143312bb7f5ce1e30::intv {
    struct INTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTV, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<INTV>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<INTV>(arg0, b"INTV", b"Intellivision", b"Dive into nostalgia with INTV on Sui! Inspired by the groundbreaking Intellivision, this coin celebrates 80s gaming's advanced graphics and unique gameplay. Relive the past, build the future on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaMNia56K5bLBWfGScBHAcz1KS6KiE3H2DGnHZzJzpwbo")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c7ff6d136cf6641205d64615e769b79c5860d20ffc3c4ab0c9369f54f96f681e3e79f2084b272e4521cc16575f4e68a0c9aa4c65eef291c372a79a1d1d3a5801d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748149896"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


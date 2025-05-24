module 0x8d8b6c83ac41550e35bc972935f73c4d192ecc0bf7c8bc90f059c971981766f4::intv {
    struct INTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTV, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<INTV>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<INTV>(arg0, b"INTV", b"Intellivision", b"Dive into nostalgia with INTV on Sui! Inspired by the groundbreaking Intellivision, this coin celebrates 80s gaming's advanced graphics and unique gameplay. Relive the past, build the future on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaMNia56K5bLBWfGScBHAcz1KS6KiE3H2DGnHZzJzpwbo")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0018f85b76b33e73c3f10ba223faaef525538ee09c46ec6b0f972f86c400970f1fe580bb9474b7ac235bfb22ded540ac226d2014083df82083f6b7a235b429640dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748085211"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


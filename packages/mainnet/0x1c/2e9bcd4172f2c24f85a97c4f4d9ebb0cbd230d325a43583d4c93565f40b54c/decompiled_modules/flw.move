module 0x1c2e9bcd4172f2c24f85a97c4f4d9ebb0cbd230d325a43583d4c93565f40b54c::flw {
    struct FLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FLW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FLW>(arg0, b"FLW", b"FLOW", b"Move like the wave to freedom in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSB5Qj9kEk5kL221gLf8xkFFiXbnLgT6uGK4GqgZ8irfv")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0029d89aa780191945d854f18719e1dbd5645b2fdb1dfee40fef889d4f9bb63eac0c830809d677f5c4e7379100e425141c84523f412043377f557e6eb27214650bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748180536"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


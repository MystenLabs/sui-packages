module 0x60a136108c3501f5db751ff56e851c6271dc4f316aca26ec7849025952535b58::dogy {
    struct DOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DOGY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DOGY>(arg0, b"DOGY", b"DOGGY", b"DOGY DOGY DOGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcoY1W8sowvMKBXcP1dLFufSR6u5aBmtRkPqyzwz2EN2N")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004bc18c9310f1f28ffec9bafb14d69e85f90c0668ce5cf7f8e1d05a1d4fc99fe349e8bade5d564eac89ea7613fc43e23d849f063928cc2c27b05caca4b09c6e09d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747842320"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xd110d2c0189bf90006fe4c2e5d01547b760da051a50d4599f835f982af0f1e55::bsun {
    struct BSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BSUN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BSUN>(arg0, b"BSUN", b"Blue Sun", b"Blue Sun BSUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWqh7XXJ2dCQ2BQArHSEcC9jn5ADmzTRRSfmNxHyRKbAm")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00820f53cf3a977d2dc086846677f0b9ffa9f2c1e8f8e48f1645e95150eeb95f61330fb6558ee8f8e812a23a3a21da177476d0ea2c5db2f85ef8234f42ad0ec50fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747324188"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


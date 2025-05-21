module 0x8ab36265a5508b7a72fb65cfac3c5891a1715de439f408ec3f3e8b53cf9da44f::oak {
    struct OAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OAK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<OAK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<OAK>(arg0, b"OAK", b"Deep OAK", b"Deep Oak, a unique coin thriving on the high-performance SUI blockchain. Designed to empower seamless transactions and foster innovation within the SUI ecosystem,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcStpJVrSYM4qvaNTMsxLFw68fB3Lj63fbFj4eu7jo3US")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e75b9d3133fb5466b7f6625c9f8bec21457e2d2b996307f26277fdc18486374ecca9ef2a599214368caf1417b2ba0e7c6402a48c5ef694b940f2b62bb3efbc01d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747810544"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


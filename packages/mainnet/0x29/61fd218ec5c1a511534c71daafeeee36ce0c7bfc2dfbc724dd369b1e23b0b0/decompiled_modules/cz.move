module 0x2961fd218ec5c1a511534c71daafeeee36ce0c7bfc2dfbc724dd369b1e23b0b0::cz {
    struct CZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CZ>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CZ>(arg0, b"CZ", b"Cipher Zero", b"Advanced cryptographic intelligence for a decentralized world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdG9GwEn5iNNyPNLtcdvvH34DufEKKFdYoV8UMHSBeuNz")), b"https://cipherzero.site/", b"https://x.com/_cipherzero", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ac0d8899814f27ee38af81b121ea9da4ce47d21b159704000258afc978f17bd72881a5f8e9dcc92546e460e5f3564076ea8e0862aa03fa7a7f4454fbd50ca102d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747766036"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


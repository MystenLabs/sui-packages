module 0x7d37f3e89a9d1dd59ce19eb87ed6e3b6a8a8c2b40f5304271e68c0f17e02047f::gtx {
    struct GTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<GTX>(arg0, b"GTX", b"GTXPR", b"GTXPRGTXPRGTXPRGTXPRGTXPRGTXPRGTXPRGTXPR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWqh7XXJ2dCQ2BQArHSEcC9jn5ADmzTRRSfmNxHyRKbAm")), b"https://www.pokemon.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00784c323d41a41b3dc014029e06044f99c2c16286d25a37e3a9c07029750efebff29dca008408954d610ab9065a8a509337e89ab24019842caf0f429b30ce8c00d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1756987378"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


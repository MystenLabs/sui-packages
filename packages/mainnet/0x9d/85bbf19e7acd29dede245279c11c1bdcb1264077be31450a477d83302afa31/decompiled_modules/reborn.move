module 0x9d85bbf19e7acd29dede245279c11c1bdcb1264077be31450a477d83302afa31::reborn {
    struct REBORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<REBORN>(arg0, b"REBORN", b"Token", b"DDD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYDjCAoUAqhgvVW4UExGgMdzPFtHJ6HW61NkjWz7UXeSg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00beb72efec2d5840a5771cc0a7b8a86b97058fc42123b118bd7cca2c93ee978ffa6bef2df46a34ec9f2d3315ec0c0fd11a9ba9637593e888f8bfa75145078bf0bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749638143"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REBORN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


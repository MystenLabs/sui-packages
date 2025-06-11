module 0xed56ab5e697fb04298f819d428366d83f25ac16816693044ecc6747d6f9e0d2d::reborn {
    struct REBORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<REBORN>(arg0, b"REBORN", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYDjCAoUAqhgvVW4UExGgMdzPFtHJ6HW61NkjWz7UXeSg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00bad91e1951c39f51b91e831de55e4da9482e6efa48885318ef810b140510ead4315e3fcec4bfd0a7f29bcb6d92a245a0750db02d9af4e76197965225c99d6b00d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749639189"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REBORN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


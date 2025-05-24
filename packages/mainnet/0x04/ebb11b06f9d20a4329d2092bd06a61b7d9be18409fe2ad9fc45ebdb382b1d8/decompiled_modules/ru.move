module 0x4ebb11b06f9d20a4329d2092bd06a61b7d9be18409fe2ad9fc45ebdb382b1d8::ru {
    struct RU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RU>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RU>(arg0, b"Ru", b"Rupi", b"Rupi is very cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWM2Q4JeMKzpU6Cobse35r8p5Y3sbQBAxuMRpVSVquaEW")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f7b046866d6daacbabca4cb8ec24927c3b9a74462446f79a580876756c6b4eab3bfa06fdf49b5e776a895c62d653e61e079faf8a9b99c8b90c8e3161f5035307d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748078118"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x3951669408b7be41f228ca770d7db63b44a907593fc77a7f82c7e72f2086aabf::mg {
    struct MG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MG>(arg0, b"MG", b"medogob", b"A meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcjuzJU8wamoSNtkjVrs1ekYUG1UqsWTCtuZdcHmHvKZm")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a86f4cae0729e4a7861c3add29ef0a7c8b09b601fb83878d1916a256afdb98dfa76d399492c1af4ef7330c2a8703061a8cca019c9f5ede5e702729eeab51f003d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748122069"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


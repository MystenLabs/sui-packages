module 0xac32cc1b3fb31913aad25d4c11b079b0f2e902ee1f382e822f0f7d78fa257011::kar {
    struct KAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<KAR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<KAR>(arg0, b"KAR", b"KARAHA", b"My life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmULoJgjv7nxR4wmonuCvtoZJ5V6RySymwSnT5eYfjZhmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00886c3305fe4cf6e6e68d693f873790c4e394d0d54c2c3facdbbbdda2f4da534eba9d06c470a37e04ee6d9eaceaf965f7d7153d76ec7859d57538a2db79e1f607d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747768774"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


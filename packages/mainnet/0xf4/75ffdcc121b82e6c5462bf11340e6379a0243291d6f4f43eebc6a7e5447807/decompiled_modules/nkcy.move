module 0xf475ffdcc121b82e6c5462bf11340e6379a0243291d6f4f43eebc6a7e5447807::nkcy {
    struct NKCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKCY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NKCY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NKCY>(arg0, b"NKCY", b"NKCYyyy", b"this is NKCY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYEK7m5Bh3twnNPGLXQJy9ecavuDC4fyNXJDMR1qLH6jV")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0065984afc3f9f039206c49295229253aef694a88640c4cf7e71890395f9973c0dd15ede6bea7926a917371586b4c2822a8f34227c92b1afc8b4fadfe0e2efeb0ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747320520"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


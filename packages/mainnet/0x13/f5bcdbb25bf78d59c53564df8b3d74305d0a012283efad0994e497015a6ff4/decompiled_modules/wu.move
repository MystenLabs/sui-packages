module 0x13f5bcdbb25bf78d59c53564df8b3d74305d0a012283efad0994e497015a6ff4::wu {
    struct WU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WU>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WU>(arg0, b"WU", b"WU keep", b"A couple carrying dreams", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma8yqgThyz8Ckapp18AWQdUKTEZC9nhcYtkupN7KfGagM")), b"WEBSITE", b"https://x.com/shih89229WU", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007c374451b1afafc048978510536f8560feb9b50924fd50bf08db8a62b099030fac6effe902b3d584a3fb09e33a49df32f45c797e0ead1b1fbe366e584850d607d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747914147"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


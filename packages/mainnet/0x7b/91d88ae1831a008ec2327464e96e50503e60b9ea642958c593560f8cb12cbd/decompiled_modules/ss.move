module 0x7b91d88ae1831a008ec2327464e96e50503e60b9ea642958c593560f8cb12cbd::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SS>(arg0, b"SS", b"Splash Scan", b"The best Trading Tool on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUvPTEVR5hRULT5F9trjeBWQMj27kwT5zxN8XEmWrKn65")), b"WEBSITE", b"https://x.com/SplashScan", b"DISCORD", b"https://t.me/HipHop_Launch", 0x1::string::utf8(b"0015dae7380c3f601afcf01e856925c1a6f9aeb9dcd58f34a32171b37d4159dc9aebb63d0439ee6c5d6cf723b0c716ce35b9fc8185befadc3b5c4e7b2af72a0c00d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747776989"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


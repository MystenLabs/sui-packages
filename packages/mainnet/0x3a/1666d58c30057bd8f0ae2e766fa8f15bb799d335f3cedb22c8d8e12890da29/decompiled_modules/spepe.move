module 0x3a1666d58c30057bd8f0ae2e766fa8f15bb799d335f3cedb22c8d8e12890da29::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPEPE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPEPE>(arg0, b"SPEPE", b"Splash PEPE", b"Meet SplashPepe: the sad king of splashes. On Splash, every jump is a meme and every drop is pure value.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbQ5Hdw8q94vXzHfg76xg8zJkUAGJtGSKkbsMxxEWxd27")), b"WEBSITE", b"https://x.com/SplashPepe", b"DISCORD", b"https://t.me/SplashPepe", 0x1::string::utf8(b"00da367f013d3de68636f22d2481d508b985a6c352e7b6ee2079fa88196e5a290e0fdb585b36d9d8835c2f523cd9ebacda14be3855c97b0a2bc530927b75f55b0ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747833283"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xacb4075cf62153d907e470fd1aa3428bb5c4a39b1e7d17092c490eb9cfc56aad::xyzium {
    struct XYZIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: XYZIUM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<XYZIUM>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<XYZIUM>(arg0, b"XYZIUM", b"Splashezium Xyzium", x"53706c617368657a69756d2058797a69756d20f09fa7aa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdqveiFDYkEBUfjiooPGt8zNibZ5phRJPMjMUstpswB3A")), b"WEBSITE", b"https://x.com/splash_xyz/status/1925166353566056508", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002e66a761ab1c930d9ee2bde4e0dac45a54d1390a28a00cb34c22fca3fa8dcea8667a1cfc4952d95bf8fabdfe37f1fdab0ac6dffc0de78a6f607bbccee87a7b04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747830534"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


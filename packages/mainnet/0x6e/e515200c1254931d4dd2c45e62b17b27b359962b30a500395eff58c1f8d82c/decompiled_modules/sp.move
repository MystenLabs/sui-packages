module 0x6ee515200c1254931d4dd2c45e62b17b27b359962b30a500395eff58c1f8d82c::sp {
    struct SP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SP>(arg0, b"SP", b"Spartak", b"best dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQrt5yR392Pr1iqgqqnuawz6S8iwCERa3bmUnPoPXwuws")), b"WEBSITE", b"https://x.com/tsemen906822", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00961e5423a7e9d861c9447c6adb4e819bcdbdb58dacdfca08354e58ee8aeadfa85e26a3536e8f59707b52328688b1a1aba61eaa29ecd9156498e8885ea9d3dc0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748206603"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x8fd2d7026906bd988097d233a4ef60443600c91412d7c8bc29c79204254ab191::strump {
    struct STRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<STRUMP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<STRUMP>(arg0, b"STrump", b"SplashTrump", b"The first fair launch Trump from the SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRKQsuqPUM2RNccWmyf1obs9BVcCqtBpiQQTN2xvoj1fj")), b"WEBSITE", b"https://x.com/realDonaldTrump", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0089b371a6a5dd0f107374a3bf24b9e41e1c1f6c81e7cace5e1aa78032e574e758d8dc5a9a21f166987705c03ee8b72243c5494c093c22709f92451bcd1cff9e0cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747839288"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x1f74ac9db93ecfb64d5cd0889d01ffa521f46b9300dc8282ffba7d63c7067d5d::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASH>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASH>(arg0, b"SPLASH", b"SPLASH XYZ", b"Launch a SUI token now with just a few clicks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmf4oB7UUyYnupRsJrBmjQAeESz8Dc5FYT2LV3Z4pPJvpG")), b"https://app.splash.xyz/", b"https://x.com/splash_xyz", b"DISCORD", b"https://t.me/splash_support", 0x1::string::utf8(b"009af1987648039ea5db43fe123a29435be3454ace8737a4bda554b544797c5e6737fd62bb83f7bb50ab29451cd5106b1443a399bb03e9d996e8b351f308b1d80fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747422609"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


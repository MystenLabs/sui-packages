module 0x926e51288564ca1858e57bc1565141fc9a2b3fd1f011fd4e9ac862e52a3d701a::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASH>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASH>(arg0, b"SPLASH", b"Magikarp on Splash", b"Splash mooner is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZR9SbPUhLiuYTRysaTXNzPyXEJF8xsYgqWvYBfqxdjHQ")), b"WEBSITE", b"https://x.com/MagSplash", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0077a2dfa7c4ccb07fd730429d1afe0e22d981d16fed17dc600f52ceb7e56077ed1b56f3f19c8dd82fae415ef2c6c801c03fe2da3a0abfc67813bf9a7e16aed505d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747776200"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


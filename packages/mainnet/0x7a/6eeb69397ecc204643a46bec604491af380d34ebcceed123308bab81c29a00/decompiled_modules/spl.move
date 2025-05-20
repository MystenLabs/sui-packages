module 0x7a6eeb69397ecc204643a46bec604491af380d34ebcceed123308bab81c29a00::spl {
    struct SPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPL>(arg0, b"SPL", b"Splooshy", b"Sploosh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcFer8rAqPTSkgB1rhrsTyVsexbMGQhosgJ87o4fuu4c1")), b"https://app.splash.xyz", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0075f6006fb6c7423e2107b5aa4d0d90bc431bd6467f42caa0d61831ff678675b0a68c55c32dd23993c3118054817099c6ae8d31243f68dcefe706f0e3f7b8510fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757097"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


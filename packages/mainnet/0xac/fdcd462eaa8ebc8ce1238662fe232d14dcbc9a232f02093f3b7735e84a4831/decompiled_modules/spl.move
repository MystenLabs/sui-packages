module 0xacfdcd462eaa8ebc8ce1238662fe232d14dcbc9a232f02093f3b7735e84a4831::spl {
    struct SPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<SPL>(arg0, b"SPL", b"splash", b"Launch your Sui memes on http://Splash.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNm91ejVqhNdF59QRVvRH82bDNueCPKfnsWf4RY7VufkC")), b"splash.xyz", b"https://x.com/splash_xyz", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b9400ebee62104af0365eab38bfb51d0b1aec86be6d919cca07b802a38b5433d9b5c7d88dda4aa9c35b8fb89c6d26183648d932973bf3442e1841d82ac74b70dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757037531"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


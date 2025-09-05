module 0x7b87c5b9040110fe4efe31375a971c52281ab151a0a2d32c3d14f18ddbe059b1::sspl {
    struct SSPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<SSPL>(arg0, b"SSPL", b"SuiSplash", b"Launch your Sui memes on http://Splash.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNm91ejVqhNdF59QRVvRH82bDNueCPKfnsWf4RY7VufkC")), b"splash.xyz", b"https://x.com/splash_xyz", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e8c9040655dc68967169dca5e32fcc6b585ac576f346572315c871178156b35e6c5d5b2839be35c2c657d319f72651fc64b088933db3f47f9edddd934ce7370dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757037661"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSPL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


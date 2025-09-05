module 0xc39afb7751a4d355f7b31061777ca4fd58916047ee1ab020b1753beaa4705dbf::splashcoin {
    struct SPLASHCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<SPLASHCOIN>(arg0, b"Splashcoin", b"Splash", b"Launch your Sui memes on http://Splash.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmd6KZ1hNLfPYfhcSRijAqLdRMsFe4MVMW8wVd42Cu2D9k")), b"http://Splash.xyz", b"https://x.com/splash_xyz", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00baa0327421fc2a29a334a9eeddaa6aa680dbd0e33674e9bc96c00e64e32827361583d72f5b545e12015ff00f61666be6dcf5be26a0dfbb1d158648d4d4f52908d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757072665"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASHCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


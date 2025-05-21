module 0x448f70facfa4cd3b494b073f20f4f796335878ce11e955b2d3726d7d4946aacc::bubbofun {
    struct BUBBOFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBOFUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BUBBOFUN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BUBBOFUN>(arg0, b"BUBBOFUN", b"Bubbo FUN", b"All-in-One Crypto Tracker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfHDhDdZkm8ePrHrAkMy4woxDbVZRzmBpr1cRU6MKqPix")), b"https://www.bubbo.fun/", b"https://x.com/bubbofun", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f5f0ad7eb51a498eb5fa8809122f30b73c1e4a8ee1f7c1cb0e094986846da18d3d2b615fb0fc47de3156fa5d9070a07c4044f8e42091bd10de7d3f1b31d22d0fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747847641"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


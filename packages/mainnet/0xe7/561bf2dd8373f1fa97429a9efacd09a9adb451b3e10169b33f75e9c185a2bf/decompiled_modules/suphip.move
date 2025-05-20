module 0xe7561bf2dd8373f1fa97429a9efacd09a9adb451b3e10169b33f75e9c185a2bf::suphip {
    struct SUPHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPHIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUPHIP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUPHIP>(arg0, b"SupHip", b"superhippo", x"4d65657420746865206e6577206865726f206f6620746865206469676974616c206167653a205375706572686970706f20436f696e210a5769746820612066756e2073706972697420616e642061207374726f6e672c20636f6d6d756e6974792d64726976656e20766973696f6e2c205375706572686970706f206973206d6f7265207468616e206a757374206120746f6b656e20e28094206974277320796f7572206761746577617920746f206675747572652d666f727761726420626c6f636b636861696e20696e6e6f766174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmcxt9ADh3j68U9JqNBcPPrTvayB94jgWEoyM1Nij48B6c")), b"WEBSITE", b"https://x.com/mrsuperhippo", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f97db685cf53438fd835b4bce157828b241c6aba9dff5cc615feec435220df13e5ea988f0c06aa2795b597d4bb1d8bb8a813890d4ca62c714246949613412c0cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747769278"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


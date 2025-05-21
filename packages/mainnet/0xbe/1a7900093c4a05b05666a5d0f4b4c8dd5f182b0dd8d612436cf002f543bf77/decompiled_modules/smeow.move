module 0xbe1a7900093c4a05b05666a5d0f4b4c8dd5f182b0dd8d612436cf002f543bf77::smeow {
    struct SMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SMEOW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SMEOW>(arg0, b"SMEOW", b"Splash Meow", x"4d656f77206973206865726520666f722068756d6f7220616e64206d656d6520636f696e20696e6e6f766174696f6e2077697468206120746f756368206f662066656c696e652066756e2e0a0a47657420726561647920746f20706f756e6365206f6e20746865206e657874206269672063727970746f63757272656e63792077697468204d656f772c20776527726520726561647921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWcVDAXzaQu7jUSGL4YAn59Fgt9Ab6fmRpgct2y8eiWks")), b"https://www.smeow.fun/", b"https://x.com/SplashMeows", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00907470cc44cc74dcb079604839a60cb21b43d33d898ecb791feb6340485bf318fbed7a32353d6dd7c4fd748d93118ab8b60933c3a1f67ded16d4a4f89278e70bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747837217"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


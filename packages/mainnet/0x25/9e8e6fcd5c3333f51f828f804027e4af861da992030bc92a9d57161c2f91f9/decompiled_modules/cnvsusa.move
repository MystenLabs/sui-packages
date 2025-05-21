module 0x259e8e6fcd5c3333f51f828f804027e4af861da992030bc92a9d57161c2f91f9::cnvsusa {
    struct CNVSUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNVSUSA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CNVSUSA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CNVSUSA>(arg0, b"CNvsUSA", b"cvsu", b"China vs USA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNb969aQWaovh8fQqt8XqmT7zE9y73XtGzvNjjPw3HQqe")), b"WEBSITE", b"https://x.com/realDonaldTrump", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0087cce0bf87ef376ca3c7e5c0f8dad578e27f0a43f81f5377da5bcc1f1782ac82b642017c5524978b295c7f6d81a7b295f972ad0c106ed22f384ac779fcbd110ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747842230"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


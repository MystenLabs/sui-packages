module 0xce43bb4072e6d860e271abf8a93dac075995be757b3f39b31c9d67dc422fde30::ftdog {
    struct FTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FTDOG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FTDOG>(arg0, b"FTDOG", b"FUTDOG", b"It is a meme coin from the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma8qrLQfW511muhQs1jqQYqiDSh5YLdYU129qsYUvpjAm")), b"www.futdog.com", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00332ff4543e75f814d2b3369627d1fd9d3414b6a57f4a2e3530eb921b2b78ae725f744a6b742c4658a866bd7e60425e25e1e024b3d81b688a1b596df578284508d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748085732"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


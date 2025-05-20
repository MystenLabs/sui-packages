module 0xbf49cf84a2b2d69f522a0ee41de2920a879ec78ae1baa1eeb73a454ae8b9050d::senzui {
    struct SENZUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENZUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SENZUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SENZUI>(arg0, b"SENZUI", b"Senzui", b"Cyber Samurai. Liquid Spirit. Powered by SUI and SPLASH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWhYdXhsQY7fZMuk8RXXAqDkhdBjz1PXSKSN7qPse5Yvw")), b"https://internetigw.com/senzui", b"https://x.com/SuiSenzui", b"DISCORD", b"https://t.me/Senzui_Portal", 0x1::string::utf8(b"00476b95a04e012806a7dcde9959e8604787ba71156b577495172fa0db038ecaeed7c402fb284ffbc9ac3a9c705864a8f136d0f1bb78d63135cbb43dfaa836b108d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747768931"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


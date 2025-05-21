module 0x23a365ed098f48aac047a786ca1d988ca89383777b55c9800dea4be9e07a273a::skui {
    struct SKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SKUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SKUI>(arg0, b"SKUI", b"SharKui on Sui", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d653b206974e28099732061205245564f4c5554494f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTmELgixkjE9uBAfVvwXWUkN8Bx3JyzVftstScwXuoKQr")), b"https://sharkui.io/", b"https://x.com/KUI_on_SUI", b"DISCORD", b"https://t.me/KUIONSUI", 0x1::string::utf8(b"008345af928e787886e0ca9f5b3c5f44b891ca355b7ff16189c92c9d267e6241325679bdfc34b94ee2b4cad2b106ec4dda907b42fcabcf57b9d2cb36811c0da806d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747839614"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


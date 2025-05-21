module 0x832aa8e2579c6eb53be9c1df179c1d71b5c73cf1ce9b23479fb2463b551dcacf::skui {
    struct SKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SKUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SKUI>(arg0, b"SKUI", b"SharKui", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d653b206974e28099732061205245564f4c5554494f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTmELgixkjE9uBAfVvwXWUkN8Bx3JyzVftstScwXuoKQr")), b"https://sharkui.io/", b"https://x.com/KUI_on_SUI", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0010aa14fc7028b911588639c932716f147271903922ca30e98b6fcc6f209ee04b941ba946a2f2409013048ad3f2dee36363ae0531d1b561da9addef243a37380cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747833352"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


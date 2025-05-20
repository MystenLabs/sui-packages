module 0x31e21fad8271183701c0726da4a767421dc43063812efcaf8792f278199768f1::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<KUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<KUI>(arg0, b"KUI", b"SharKui", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d653b206974e28099732061205245564f4c5554494f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTmELgixkjE9uBAfVvwXWUkN8Bx3JyzVftstScwXuoKQr")), b"https://sharkui.io/", b"https://x.com/KUI_on_SUI/highlights", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00604ab29192ac74ce4e038af89afb94100c2a630e049ed74d575c263836d67f3f9442c9009e45a7149d448fcd5cc432d43ee43060d90c923787124b8a296d9a01d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758955"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


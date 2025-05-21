module 0x93ef4f9ffeaaec5e49c3ba6e88ea633486eeac4ec5f54172a5bed0435eb68090::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<KUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<KUI>(arg0, b"KUI", b"SharKUI", b"SharKui, half-man and half-shark. A legendary being who fights striving for a more good world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTmELgixkjE9uBAfVvwXWUkN8Bx3JyzVftstScwXuoKQr")), b"https://sharkui.io/", b"https://x.com/KUI_on_SUI", b"DISCORD", b"https://t.me/KUIONSUI", 0x1::string::utf8(b"0069ca7f1ac2a040b665d8f075f9f43b1a803981219a744ae58d461b18562cf4986eefdf0d790abf2a6fbf8b90f1c46181792a76af9f8ab85e6a61bc538e249c03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747845469"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


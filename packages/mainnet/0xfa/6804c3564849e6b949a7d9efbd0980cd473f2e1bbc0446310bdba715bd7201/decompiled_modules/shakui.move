module 0xfa6804c3564849e6b949a7d9efbd0980cd473f2e1bbc0446310bdba715bd7201::shakui {
    struct SHAKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAKUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SHAKUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SHAKUI>(arg0, b"SHAKUI", b"SharKui", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d653b206974e28099732061205245564f4c5554494f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTmELgixkjE9uBAfVvwXWUkN8Bx3JyzVftstScwXuoKQr")), b"https://sharkui.io/", b"https://x.com/KUI_on_SUI", b"DISCORD", b"https://t.me/KUIONSUI", 0x1::string::utf8(b"002e6cfa719780c6c6cfe944d607cdc7efacfa1bab41d89b3355f89d6db8114181a0faf9b0c6db924de41a92f9068e9a5443ed8f6c7b2a17b9467b13ce0df6cf05d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747845671"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


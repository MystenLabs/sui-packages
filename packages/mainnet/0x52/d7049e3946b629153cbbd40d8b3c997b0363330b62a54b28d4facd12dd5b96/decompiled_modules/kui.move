module 0x52d7049e3946b629153cbbd40d8b3c997b0363330b62a54b28d4facd12dd5b96::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<KUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<KUI>(arg0, b"KUI", b"SharKui SUI", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d653b206974e28099732061205245564f4c5554494f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXyGV6UwfMJojNMAE6BgLcZhzqk3S3eEcAKZUo87gkBt9")), b"https://sharkui.io/", b"https://x.com/KUI_on_SUI", b"DISCORD", b"https://t.me/KUIONSUI", 0x1::string::utf8(b"00bbcbb974a8fbf1b8f5d19fb79963a1367ba410e2c245fc26cf78247d59a79fec05f3ee3ce88ce00c264b1a73b84f7064a170b554448415a104969545adb4040ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747842707"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


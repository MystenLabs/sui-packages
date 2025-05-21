module 0x1211b365962807e19e0b846280f7426e9ea4861b17b492d054e46ecffb1c6807::kuis {
    struct KUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUIS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<KUIS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<KUIS>(arg0, b"KUIs", b"SharKui", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d653b206974e28099732061205245564f4c5554494f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXyGV6UwfMJojNMAE6BgLcZhzqk3S3eEcAKZUo87gkBt9")), b"https://sharkui.io/", b"https://x.com/KUI_on_SUI", b"DISCORD", b"t.me/KUIONSUI", 0x1::string::utf8(b"008872c38d1dfa3f6ca9ae1f6fab61066068dafe441fa28d948cb778aafbfec281685518c061861a26f85aa33945d0e8b8968e14790fd3e96a7f93c70395d81d04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747838728"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


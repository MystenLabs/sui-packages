module 0x66aff4d49703d2d30c67dfa9290159465488dab99ff8746ca7f32e0260b798a2::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUI>(arg0, b"SUI", b"Sui", b"Sui on Splash.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWayGYRpSi1djbeaQUQosHspvpNK9FDmcct3MmQCfzmiu")), b"sui.io", b"https://x.com/SuiNetwork", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0008f99257a667f6a2e54188d6958981cae376d7eb80549ae19dca27614f3bcd39b93498f68f7a87f47e0ddd4c4f4a148d23ba26bee055806e34cdf21f3877290ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756945"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


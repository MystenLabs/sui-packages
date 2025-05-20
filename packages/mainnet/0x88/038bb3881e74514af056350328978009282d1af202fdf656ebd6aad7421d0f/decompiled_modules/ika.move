module 0x88038bb3881e74514af056350328978009282d1af202fdf656ebd6aad7421d0f::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<IKA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<IKA>(arg0, b"IKA", b"IKA on Splash", b"Just IKA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVHXQGqcV2iTBxoFCjKx4zXZTkppJ98TaUC4E8zeNutTG")), b"https://ika.xyz/", b"https://x.com/ikadotxyz", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00551c30561fef8db11469e90d4f11c03d2459a78447911410d942f501dc0b3eb1d48fa627ee7c3950bb7cd3b928629048e5b5029f19fe7759d83eb64d6bb4b702d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759660"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x97647ffb4701cdeefc376adff0e68c394c7fea5fe1d83ebe9540a4bd586b1469::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<POP>(arg0, b"POP", b"Cat", b"Caty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW2yn8Gvwa2updz5KcTzQJ9uXKaPikKiZnnKMLDX2miC5")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0049e0acec069380b345812f5d0cf2728d0a9b59b402b88143047e594564f87fb72eb8f026557bd48b987f68333a2f1f283bab17d4393933a6ca62724c6dc91604d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749647444"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


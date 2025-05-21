module 0x43ec9b6815fb2722ee10687228e950b8cd912a8edf56eb4c789e8ddd9178c84a::bull2025 {
    struct BULL2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL2025, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BULL2025>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BULL2025>(arg0, b"Bull2025", b"BULL RUN 2025", b"Welcome to the Bull Run 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXMAJMNaFv9PzSAuwJ3QXpXdsUMvCaYt6K2iK9muyvcSq")), b"https://x.com/BigBull2025?t=6xSt4jSdtDqFdwfYQ-kQ2w&s=09", b"https://x.com/BigBull2025", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004db64f809ef25fbcbc0dada8dab585cfd1e126c21986ed434ec3cb4d7b349f60dd72ecda110f5def2626237c0bfc44bfb65237d0584d195efacf2a8bf416b701d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747802600"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


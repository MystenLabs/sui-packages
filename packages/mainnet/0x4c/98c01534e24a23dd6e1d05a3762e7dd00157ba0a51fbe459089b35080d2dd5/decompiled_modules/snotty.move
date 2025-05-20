module 0x4c98c01534e24a23dd6e1d05a3762e7dd00157ba0a51fbe459089b35080d2dd5::snotty {
    struct SNOTTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOTTY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SNOTTY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SNOTTY>(arg0, b"SNOTTY", b"Suisaurus", b"The one and only Suisaurus. All others are extinct. My name is Snotty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfTyAGjFpxNr6gwdfiy7miwQN2F57pYFbATRuUxD8dq8T")), b"https://x.com/suisauruss", b"https://x.com/suisaurusss", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008f344379e01d73dbe1e2d9cf353f4828330ee57c916e691f047b0b5a259fcb0863518ebbcb040fb57f4eb629ba3edcd3be0fa1dfc948005a8a439385f4698a0ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756772"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


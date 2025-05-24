module 0x1bb710a12cd4107f7ecd4bd92ac595933e5e70b3770f376f6b213523681d4c38::rmos {
    struct RMOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMOS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RMOS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RMOS>(arg0, b"RMOS", b"Rich man On Sui", b"Let go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQT5VTAu3GxLgyEjskEpe9yakPvB1wcpAMZR1rNx8bNLb")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0095f0e159f1d7e36da17e8976f756b3b78b246f34bbcbc55b2e5f6d2747ec56cddb4c819cdef1aecb44d53f6266d6ebfa5352a014cb37c639536ec597bc278905d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748063165"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


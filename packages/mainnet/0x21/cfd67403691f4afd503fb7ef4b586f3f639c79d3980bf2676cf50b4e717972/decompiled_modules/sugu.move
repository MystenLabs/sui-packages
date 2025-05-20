module 0x21cfd67403691f4afd503fb7ef4b586f3f639c79d3980bf2676cf50b4e717972::sugu {
    struct SUGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUGU>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUGU>(arg0, b"SUGU", b"SUI Guru", b"SUI Meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmehMvcT27SHMCH3tzH4ny1y2fBh5BqCucbbUX51BvbV8B")), b"guru.ai", b"x.com/SUGU", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009a07c59cab9c606c29c7d99517a5f52f859f344e6fcd8090a839072963925a81868f5786efd0df56302fe988001c63436978f614767fc765e80d5772e139bc08d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757770"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


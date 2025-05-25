module 0x5491ae9f1fce38ce52aa3dc24dbd19f03b782855739e978a043ea8e24af53e3::lcb {
    struct LCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<LCB>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<LCB>(arg0, b"LCB", b"lucibear", b"hobah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXsit6au9AST7YXq9uW1kYdgKTLMrcDbzMDQPCT3nKuvZ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002928c48069f535bcfb14892d4f648b166e11bf72ba30dde3abb728bb4e44861b01925d6ac65cdc0759cf9fc6ede715f869a89021553030afa4595bb3d4843a03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748166851"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


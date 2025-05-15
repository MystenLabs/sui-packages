module 0xe77c75846efbf1195bd6898c8eda47d2999a519bcb070964b3a3ce445ca2ebac::rr {
    struct RR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RR>(arg0, b"RR", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006e8ffda1e967c6141e25946931642d8432dd3faad8de29e431fc05dd8bda8cf66d095cedeb24395ef63322d46301c794d3de2dbf8217c29bbbbb2c2cd18b2409d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747318370"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


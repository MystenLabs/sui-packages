module 0x2e81aac5b2e86d1e70697108384dd58fbdd69db33f74852b4df3e99eebc122fa::netst {
    struct NETST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NETST>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NETST>(arg0, b"NETST", b"Netest", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002c310411daf936d5896e73bb3c02db1fed0ee0aed00fd7a205ac7d1a79186d70d7f1cd60dfb669838b896f0525e08bc41d804cf56d1b4d52a7fce1816b233209d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747219522"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


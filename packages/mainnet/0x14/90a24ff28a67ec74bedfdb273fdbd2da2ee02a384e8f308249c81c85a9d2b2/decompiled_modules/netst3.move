module 0x1490a24ff28a67ec74bedfdb273fdbd2da2ee02a384e8f308249c81c85a9d2b2::netst3 {
    struct NETST3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETST3, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NETST3>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NETST3>(arg0, b"NETST3", b"Netest", b"NETST3 for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a7db651a47331238bb5083e3f4c4a0e80316334d733dc68e92dc8e2b7e08c60b9aef22314c94c2a7d2966abecb676929be2e17e3e2211fb8e9a09875bc859a0bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747237470"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


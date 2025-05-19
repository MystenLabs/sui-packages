module 0x7eacf705079cf3c7d461f6391d6fa221d6698e985c15401180c73d992d8c4b37::netst124 {
    struct NETST124 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETST124, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NETST124>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NETST124>(arg0, b"NETST124", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a0fea6b1c9cc81d562607dccb0bacabe767312adfe6612d413f9cb5f23a179929728d34d1dfadde6e8d646a7df3c2b52747355cba6f85fec8ab20ed9b532620bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747653186"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


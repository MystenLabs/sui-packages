module 0x549287bda6017155df41d34f1b98192c725892a5e4bc45c0c4959b64d30010c9::netst {
    struct NETST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NETST>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NETST>(arg0, b"NETST", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007aad2e589b3718e862758888afd479cb837af6c882c8e679fe17c8aa59b0773a27a47a8178255ef189746a396c6775bf977c8724e95986d1a62891ec269ef403d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747653307"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


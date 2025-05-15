module 0xd119a1841b2dc5215531a41618f801b674c843f9a6614dac3027d247596e040c::netst4 {
    struct NETST4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETST4, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NETST4>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NETST4>(arg0, b"NETST4", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0025082f1fea0d89e1b76e251f04f323e4b75be662946a4c18f616f20d443fc5a4f3eee156911a4e2dbd5aef588e7ae3079b16a23aacb8ba547934d9fbbb0e6b04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747292896"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


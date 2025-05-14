module 0xaabe61aa0bf57077aa39f36fdfe038c3db45a91add349bfe8b113024841d2a2e::netst2 {
    struct NETST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETST2, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NETST2>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NETST2>(arg0, b"NETST2", b"Netest", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00031dd7a7af89118991a20be537669e609b306bedf083b90285c1058239ceaf012de7b4088b9e90444cbdf8755b5afcd8c416d91e5b8cd9ea393fae9b7e197c02d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747220900"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


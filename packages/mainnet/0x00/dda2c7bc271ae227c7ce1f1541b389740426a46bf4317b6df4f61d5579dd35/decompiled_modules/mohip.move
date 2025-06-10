module 0xdda2c7bc271ae227c7ce1f1541b389740426a46bf4317b6df4f61d5579dd35::mohip {
    struct MOHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOHIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MOHIP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MOHIP>(arg0, b"MOHIP", b"Mind Of Hippo", b"The Thinking Face of the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPX3Du7bQSoP1wGuLrpEzoSW22S2ag1TqgdLTkBFDBUfC")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00786598849265693983b2290b5a8e2618096b64a75212ec13807a46210b37958dcaf9093c99b8a2c13f28ca2bc9e92710a48d6302b560434f128a363ad908dd0bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749571070"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


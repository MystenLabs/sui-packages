module 0x156d1aa0d727b61dcb45821e121265cb04866e181b66b2e5e128213dd063703::mohip {
    struct MOHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOHIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MOHIP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MOHIP>(arg0, b"MOHIP", b"Mind Of Hippo", b"The Thinking Face of the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPX3Du7bQSoP1wGuLrpEzoSW22S2ag1TqgdLTkBFDBUfC")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004339f6072dd163d92990e023dd24891bea9b0a1367c5cb58a7ffc31b83caa6350d75a15926a2a39e1d372055ea6a741302585a74c713a1484650af970e504b0cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749591224"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


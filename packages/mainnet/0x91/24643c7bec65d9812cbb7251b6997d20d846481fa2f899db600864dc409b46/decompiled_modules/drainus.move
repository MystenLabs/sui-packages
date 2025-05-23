module 0x9124643c7bec65d9812cbb7251b6997d20d846481fa2f899db600864dc409b46::drainus {
    struct DRAINUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAINUS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DRAINUS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DRAINUS>(arg0, b"DRAINUS", b"Drainus Protocol", b"Keep calm, it's just an oracle bug, team working on it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQkVvJ8vuTfsfBS68kuk2BHULhbPp7koU8zurWWzi7afw")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008aacfe1e6ebc6a64e6edbd0ad810eb7fa883983b06c402cfcec2497e14ab674d622cb0128ae80e4c7710bee77be9d0bbf2048a3ad5b5abe7933ab9464c6c7902d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747994063"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


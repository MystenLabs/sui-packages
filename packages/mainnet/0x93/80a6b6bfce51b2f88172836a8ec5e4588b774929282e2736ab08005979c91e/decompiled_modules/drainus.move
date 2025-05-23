module 0x9380a6b6bfce51b2f88172836a8ec5e4588b774929282e2736ab08005979c91e::drainus {
    struct DRAINUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAINUS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DRAINUS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DRAINUS>(arg0, b"DRAINUS", b"Drainus Protocol", b"Keep calm, it's just an oracle bug, team working on it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQkVvJ8vuTfsfBS68kuk2BHULhbPp7koU8zurWWzi7afw")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001947a7593893547a7e589b12457ddc9bbe9110dd4b3ec7f5050d95246161bee15a03e8bb01f800d39dfa45cb95f8e50bb57d37524dafbe419b22507c568be70fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747994220"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


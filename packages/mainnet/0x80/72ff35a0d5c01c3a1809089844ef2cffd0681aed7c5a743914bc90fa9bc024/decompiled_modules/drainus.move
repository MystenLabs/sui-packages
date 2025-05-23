module 0x8072ff35a0d5c01c3a1809089844ef2cffd0681aed7c5a743914bc90fa9bc024::drainus {
    struct DRAINUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAINUS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DRAINUS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DRAINUS>(arg0, b"DRAINUS", b"Drainus Protocol", b"Oracle bug, team working on it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQkVvJ8vuTfsfBS68kuk2BHULhbPp7koU8zurWWzi7afw")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0027f2dcf607cca638e16a54ebd80cefd6426acef3aea35b5e27cd6f9b44fd12ed35fae061d01525cc55783d17471f519a7d759e1eb298e6fa660b29362954d806d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747994387"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x5054665b4547108a19c3983edc44a08424ae3bbe01e114f457924b44b9d2db9d::moh {
    struct MOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MOH>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MOH>(arg0, b"MOH", b"Mind Of Hippo", b"The Thinking Face of the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPX3Du7bQSoP1wGuLrpEzoSW22S2ag1TqgdLTkBFDBUfC")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00fbdc4f8270dcae20d52ff0746236b29450705270343f42d18be2f1e9238747943e007b56ff92dd94c23cbad37ce807622f32a4fbffc0ef4c54bde04efeff0301d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749570386"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


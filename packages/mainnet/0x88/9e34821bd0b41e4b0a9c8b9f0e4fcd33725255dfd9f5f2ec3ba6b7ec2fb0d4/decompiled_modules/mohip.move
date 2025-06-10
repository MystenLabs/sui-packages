module 0x889e34821bd0b41e4b0a9c8b9f0e4fcd33725255dfd9f5f2ec3ba6b7ec2fb0d4::mohip {
    struct MOHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOHIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MOHIP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MOHIP>(arg0, b"MOHIP", b"Mind Of Hippo", b"The Thinking Face of the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPX3Du7bQSoP1wGuLrpEzoSW22S2ag1TqgdLTkBFDBUfC")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00650a2be2b86e35f73a541ad15200df7e008ddd5b6523d5e069d2dc4ca413ee2e69ba1bde764183a34052dfc11eb3ea7547d275c9f3bbe02aa39f8eadb6a64209d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749570853"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


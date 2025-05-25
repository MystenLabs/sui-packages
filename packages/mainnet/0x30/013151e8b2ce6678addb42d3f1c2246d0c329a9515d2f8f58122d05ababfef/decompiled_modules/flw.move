module 0x30013151e8b2ce6678addb42d3f1c2246d0c329a9515d2f8f58122d05ababfef::flw {
    struct FLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FLW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FLW>(arg0, b"FLW", b"FLOW", b"Move like the water wave to freedom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSB5Qj9kEk5kL221gLf8xkFFiXbnLgT6uGK4GqgZ8irfv")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0057d2ab0590ad225c5e455d55023f8fd52133fa59fbb7d52560422c3f332616a8022d714366ff83cf85f1f292233d4eb2e76f2318ce88645f2d1038dfa7687e08d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748180058"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


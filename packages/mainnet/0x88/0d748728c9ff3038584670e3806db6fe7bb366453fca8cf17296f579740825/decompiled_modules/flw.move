module 0x880d748728c9ff3038584670e3806db6fe7bb366453fca8cf17296f579740825::flw {
    struct FLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FLW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FLW>(arg0, b"FLW", b"FLOW", b"Keep moving like the waves to freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSB5Qj9kEk5kL221gLf8xkFFiXbnLgT6uGK4GqgZ8irfv")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001f2929fa2d38f3be508174cc69301e3173eb5d1d7a78f61a82db406b3c0d5b44427a38abe9c72f21e3ef8ff4c8ca1f1354c980651de0a49efc49dd8e2a8b8f0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748179873"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


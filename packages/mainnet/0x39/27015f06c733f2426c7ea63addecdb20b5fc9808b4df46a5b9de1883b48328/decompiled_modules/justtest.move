module 0x3927015f06c733f2426c7ea63addecdb20b5fc9808b4df46a5b9de1883b48328::justtest {
    struct JUSTTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTTEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<JUSTTEST>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<JUSTTEST>(arg0, b"JustTest", b"Just Testing Stuff", b"Please don't buy thi. I am just testing stuff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcngTtZjPXpAV6wYUrBB7ChxWaE4QoAx14hCZUM5Jphri")), b"https://www.google.com/", b"https://x.com/defi_or_defuck", b"DISCORD", b"https://t.me/me_hkj", 0x1::string::utf8(b"00fc7a82c748d0e847b0d12b7820ea8cb9524029cce76f5839b70c44baad2c4ff9b28f40fc344fe85e0587581523772e7c407d4ae42abc1094f9d9f58b531ef809d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747761372"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


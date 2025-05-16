module 0xb031ea0a81729ad145eadc8f2e6b49c006b0bac09e58733e3e5ba3aeb47f51c2::back {
    struct BACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BACK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BACK>(arg0, b"Back", b"back", x"5468652064726970706965737420484950504f206f6e204354f09fa69bf09f92a7204669727374206d6f766572206f66205355492054484520484950504f205448415420484f5053207c204a6f696e20746865", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPC8g6Bw7FgqGof946FB3LTXgtoDp1dXM4ZbGGqLVE2uk")), b"WEBSITE", b"https://x.com/hippo_cto", b"DISCORD", b"t.me/HIPPO_SUI", 0x1::string::utf8(b"001059523c8ccaa99d095dca9ffa85222639c07622391bded78e1550deaba5f2b6a27380922ed8db9f467a7060ec2a3aa741598d40804aa4db190ac3828dd02f08d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747423272"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


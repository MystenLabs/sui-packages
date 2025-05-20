module 0x10880cb1d11215e2b0a9dfed2786fb2fbd8f8dd4c5059f2f3fde937cf7d882e5::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HIPPO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HIPPO>(arg0, b"HIPPO", b"Hippo CTO", x"5468652064726970706965737420484950504f206f6e204354f09fa69bf09f92a7204669727374206d6f766572206f66205355492054484520484950504f205448415420484f5053207c204a6f696e207468652024484950504f20636f6d6d756e69747920686572653a20687474703a2f2f742e6d652f484950504f5f535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma5XRGB623b2PjQ9whWwUkTCdKtHD6JjrDGQsQvc9kbBY")), b"https://flooz.xyz/hippo_cto", b"https://x.com/hippo_cto", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0051f5b0c855bf16b943c4995e1ae70ce45c25c49d7e985062b5d4f5b5bef7908afc7590f45632220b52301ac9945f6367189256cbddb388a7b1f885759011b40ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759316"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


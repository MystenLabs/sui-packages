module 0x7596752a9b92e5cba7cadc47777eef6235ec23b838505947eba51bcfebe2e080::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HIPPO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HIPPO>(arg0, b"Hippo", b"HIPPO", x"5468652064726970706965737420484950504f206f6e204354f09fa69bf09f92a7204669727374206d6f766572206f66205355492054484520484950504f205448415420484f5053207c204a6f696e207468652024484950504f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma5XRGB623b2PjQ9whWwUkTCdKtHD6JjrDGQsQvc9kbBY")), b"https://flooz.xyz/hippo_cto", b"https://x.com/hippo_cto", b"DISCORD", b"https://t.me/HIPPO_SUI", 0x1::string::utf8(b"0031753849f3d9e02f28c7460b5b0c588c4c1c4b06f41629274243f20a8b0ee8c73c13bd766ab3a431b1e65977c88c6ca4c0b33b980c7f10744ec3f8fcb86c2803d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756802"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xf64956fd9eb4c01338d970cebbbeaf84118da82d7b213aee31d44c76a6fb5c39::dugosagi {
    struct DUGOSAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUGOSAGI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DUGOSAGI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DUGOSAGI>(arg0, b"Dugosagi", b"chau003", b"dugosagi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRNJw3h6XocKceoAtL9wHzfjkm8zFV9TUEBMYsXCPwSQa")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007095507c3f1aa5278af4be4a89fd5d36d90aacaef78a901a8fa08dc13a9c96006bb116c41743903afb8c4f9bcead346409b432102d6f9f906dfa68e66bcb5404d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748106949"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


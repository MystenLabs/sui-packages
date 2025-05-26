module 0x2d6730dc08edf42b5537508e67d66fe66e711679341e6056edb5753bb9d81a22::vnnl {
    struct VNNL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNNL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<VNNL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<VNNL>(arg0, b"VNNL", b"Vietnamese Non La", b"Ever seen a dragon with Non La", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdwBX36G33Dzx2tgDGHZniPxXYtMkDQAZtfAjxGkCEfwg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0051874bf60d54c31c19afeec0da692f20e143a4d49ece89177dc7ca1269f2315fcc79a7c7cd2673ddf464473019ffca5cb41a9c9cf1d45701ff9723e1ed6d0305d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748253102"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


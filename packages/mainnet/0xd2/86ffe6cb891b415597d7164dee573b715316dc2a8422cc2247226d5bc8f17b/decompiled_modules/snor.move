module 0xd286ffe6cb891b415597d7164dee573b715316dc2a8422cc2247226d5bc8f17b::snor {
    struct SNOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SNOR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SNOR>(arg0, b"Snor", b"Snorlax", x"497427732073686f7774696d65210a546865206269676765737420506f6b656d6f6e206f6e2053554921f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSA7pS2gmH2vwGw26rogRmT6ymKxAZT2RSdxoKdT6u4QT")), b"WEBSITE", b"https://x.com/SnorlaxSui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0070f6c888839aa4b272ef71be2277f6851c1743b50cfe2bd2aad67bcf012199be6b441c7f2561777c9d90863db916b839bc4f610da905d8bc81ef332fd3aca102d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759048"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x4357d9460707c3179b214a0eea78c7663d2658073ad0985082cb089704d4d6b0::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<CAT>(arg0, b"CAT", b"CatTopTOken", b"Some best cat token Buy please Anton privet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmb38y6LLtUGWJCFLDgyGE4KeA46DgVuiAtT2KrRECqj1Q")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009f52a0803347cea13fc4a3d40b4fc20f5f8b7ac6f77ccdba9bcb20e40bf70ee071ea2e75a0674cbfc6a2d2d31bbd27528c94fa4074c1a166458cc7c3cf5c6e00d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1756986611"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


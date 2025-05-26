module 0x4653ddb9b0df095ecc87e9638eb52f96d1ec177ffdb72548e2e60a8f5dc0ff11::cl {
    struct CL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CL>(arg0, b"CL", b"Crystal", b"lets save the world together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTVyD7NPCwTzCCjDFmepThMK9qasFWLJCYGhrNNS9yc9K")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0053c24055d49717f861717bd2b8effb45af1cf1b84f3da5a41b5703dd4986046bacfc430e4645e0d54cf42d961c8e6b5f2ad161b0da5424b1a896540f9b600a01d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748275438"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x50c9caa2573cc3f1665489fd7acd527a1e63d8ed2f5fee47e1f8eeb44b13e95::dugosagi {
    struct DUGOSAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUGOSAGI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DUGOSAGI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DUGOSAGI>(arg0, b"Dugosagi", b"chau003", b"troll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRNJw3h6XocKceoAtL9wHzfjkm8zFV9TUEBMYsXCPwSQa")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0055a4f465002a7b319f4ab1582b98125f56a567b6c9a3a4c0a9861e9b8ad6d320e54f525a57fb8b2a8f2e3f2953d96bfd15b573595ba78a5f3393505615c0f80ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748106787"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


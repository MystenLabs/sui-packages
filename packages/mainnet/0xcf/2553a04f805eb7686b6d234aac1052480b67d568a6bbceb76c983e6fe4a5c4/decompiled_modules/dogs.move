module 0xcf2553a04f805eb7686b6d234aac1052480b67d568a6bbceb76c983e6fe4a5c4::dogs {
    struct DOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<DOGS>(arg0, b"DOGS", b"Token", b"BIG SUI DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW2yn8Gvwa2updz5KcTzQJ9uXKaPikKiZnnKMLDX2miC5")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003dc75e95fba157ffae258694a45e7d2db4b9f41af9a17796c02cae74cef5d69ded73eb06cc1f8d75727dbabbbcba1fdd017486b089512cd2697d7c359ac68d0fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1750093065"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


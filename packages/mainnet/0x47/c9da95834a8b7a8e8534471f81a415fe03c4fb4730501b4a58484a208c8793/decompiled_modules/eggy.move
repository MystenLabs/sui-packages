module 0x47c9da95834a8b7a8e8534471f81a415fe03c4fb4730501b4a58484a208c8793::eggy {
    struct EGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<EGGY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<EGGY>(arg0, b"Eggy", b"Eggsplode", x"546865206261627920647261676f6e204567677920626c61737473206f7574206f66206974732065676720616e6420696e746f20796f75722077616c6c6574210a45676773706c6f646520697320746865206375746573742065676773706c6f73696f6e20696e2063727970746f2e0a426f726e20746f2062652063757465207769746820626162796669726520656e657267792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdxNtBMXKaPkHUbDz6CGGP9bJCTvZyYqkT7AyrtzkWaJn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0054bc3d47486970ddf4be930e58290f6db113180ace8185b26b1aa6e5ba6cb17a7f17023e115072e34d6a1695e57d759978c8c1ca871268d552364a4e59da760bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748107168"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


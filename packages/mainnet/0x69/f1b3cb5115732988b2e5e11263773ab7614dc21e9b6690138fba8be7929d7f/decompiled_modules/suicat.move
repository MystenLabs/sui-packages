module 0x69f1b3cb5115732988b2e5e11263773ab7614dc21e9b6690138fba8be7929d7f::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<SUICAT>(arg0, b"SUICAT", b"SuiCat", b"Launch your Sui memes on http://Splash.xyz Launch your Sui memes on http://Splash.xyz Launch your Sui memes on http://Splash.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUohRe6gBafVU4yrsYKp7LRnosnNRKZgng8ioinUWGj1V")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00dcb821c2bfaf9fb61b1da141e7ec992a7936ab6af4cd0eb5dd838fb815f6b881f9c9ee6692a5412df33fe541b26dca5d8999b13ae3925f8edccad620f59c690cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757050271"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


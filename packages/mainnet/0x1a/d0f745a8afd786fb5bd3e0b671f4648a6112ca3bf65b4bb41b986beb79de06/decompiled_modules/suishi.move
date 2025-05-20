module 0x1ad0f745a8afd786fb5bd3e0b671f4648a6112ca3bf65b4bb41b986beb79de06::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUISHI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUISHI>(arg0, b"SUISHI", b"SUISHI COIN", b"$SUISHI is the freshest memecoin on SUI, fast, fun, and full of flavor. No promises. Just vibes !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQz1iPSb33L5zd6S7dLsekqiGo2pWb4xa19ZKa4TJbvd2")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009b6528c1186c98e3d29138e6934d4d4eccd419b9f4cd7c5c8f14b6ed5f78a300d7e59ad746d53112bc13309b044000a3c44899a00362c403bcddd4b79c50990fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747766874"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


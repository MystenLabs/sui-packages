module 0x8f45d636214a26e17153f4bab8f0bb31887a2a6e02ac597828eeca0d11a94afd::rrr {
    struct RRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<RRR>(arg0, b"RRr", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW2yn8Gvwa2updz5KcTzQJ9uXKaPikKiZnnKMLDX2miC5")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d67635ac43d92bd7b0cd765328816b8c795b6555fc76aa342af77a4394cb081523102fa9f7993d34052266b648dde9d5fef651e21097197d3c29d83ea8ccb30cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1750099597"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x3d5d8b8309f8cbd0196db6444dc41dee6d6fff8856d00949fd33e0ce2e894904::bomboclat {
    struct BOMBOCLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMBOCLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<BOMBOCLAT>(arg0, b"Bomboclat", b"Rich Millionaire", b"Bomboclat Rich Millionaire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQ6f6BWhrcxEMq6wQq1FW3KDLop9AownJZVz4bhssVT46")), b"https://www.tiktok.com/@dailytopfivess/video/7477649892618292502", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c871abdf624a6691524f7c4c2a3aa957b3ea72d39cb2382d7d888e6899a81b2d34d930c09dafd67531d755ccd4ebb57c28db95b74bbacaa9155ee74d5e5dbf0dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757004020"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMBOCLAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


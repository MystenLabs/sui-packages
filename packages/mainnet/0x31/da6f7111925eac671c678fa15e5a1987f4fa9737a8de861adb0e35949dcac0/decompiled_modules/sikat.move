module 0x31da6f7111925eac671c678fa15e5a1987f4fa9737a8de861adb0e35949dcac0::sikat {
    struct SIKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIKAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SIKAT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SIKAT>(arg0, b"Sikat", b"Sikat Cuci", b"Sikat buat nyuci baju", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmV6euzP5GtC9pYrvZ3y6aUdHTbPWaxWQrtNZTKV6JkT9M")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0029b701481c7d75c9cb22bf9560f5a6dcde5432541559d138a3b84e05c05433e086f7d44b20ea905d41a50327878742660d11088baed6e88b952daef45a234402d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748094569"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x49a94d1b5d7156e49d1229af350846473f05e2376c1afb4a7d6b8ae57e1d3bc6::wu {
    struct WU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WU>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WU>(arg0, b"WU", b"WU keep", b"A couple carrying dreams", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma8yqgThyz8Ckapp18AWQdUKTEZC9nhcYtkupN7KfGagM")), b"WEBSITE", b"https://x.com/shih89229WU", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0095ff9f0755bdd87aa17dcd5c83aeceab57351317d4f223b331ad3728edf3a7b2ea83e41b4a7305872dc8a02ed61737175cc36c17f6ed1d71aa6d28d2e9805f0bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747915130"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


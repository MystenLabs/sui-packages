module 0x2ddb483d1577c815930a3e3d70901c038b0c1d1dec2a502eb2de47cb15fe6e66::npm {
    struct NPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<NPM>(arg0, b"NPM", b"NPM Attack", b"the attacker managed to steal only $66", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbLu7eF78mFoLNsKNKjEtivEzWjPDWdYh6dGQjqgEa4Zk")), b"https://x.com/P3b7_/status/1965094840959410230", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e996b0c33eb1db5da0ec30b6331220b88e778ebc8f47a891cf7915e5c3de2349075c42b756cb0b5345015ed113de4accb3a48685328bf885174dc23943515808d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757367194"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


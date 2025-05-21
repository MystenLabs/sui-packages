module 0x5b239ceacaff8e4c34ce51379a4429b4130ea6ddd379ba6c41c3175f295569fb::xiaojuren {
    struct XIAOJUREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIAOJUREN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<XIAOJUREN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<XIAOJUREN>(arg0, b"Xiaojuren", b"xjr", b"xiaojuren", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSmeN3sjbggj2zRWE2yAzarokCBfo8LhFNiHLZ8PeXVPK")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00eb00b4be4d063d75fbf5ce50f8ae6f6bb5240c942171af4ee8a1e85e174f39400411336af02ce7a678462418341e80315568f34d21939e22e541f2c796a9070cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747797131"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


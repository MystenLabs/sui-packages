module 0x6ed8fc32f7c5895042de69bcff8deb0b50c7bf74c5919754c0359b2eb156b3d4::slime {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SLIME>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SLIME>(arg0, b"SLIME", b"Sui Slime", b"The first cute formless monster on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPnaE4GR8Q4PY9Uo5U9sei45G33bP2Zonz1gRsjJXf5di")), b"https://suislime.com/", b"https://x.com/SuiSlime_", b"DISCORD", b"https://t.me/Sui_slime", 0x1::string::utf8(b"006c4d04f4dcfa656185acd55e594a3055c65373924675339a302cf2548259c34c68fb6c728651c8de7bac2736a5505df2f5be89fd1e259387abb583606dd65408d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747771503"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


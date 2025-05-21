module 0x90b5821d5f4812aa21dfa155b115e7983ab254403960bbcc697907f2152a982a::jhon {
    struct JHON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHON, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<JHON>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<JHON>(arg0, b"JHON", b"Johan Liebert", b"Just Test Token , Join For Airdrop : https://t.me/PegazusEcosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmU36SBkVcvw9CzXZSfm1Vd5VG6WwYYvovBkejx5bNBzvT")), b"WEBSITE", b"TWITTER", b"DISCORD", b"https://t.me/PegazusEcosystem", 0x1::string::utf8(b"00ac35fab29aecef2709f62ba197a95c28762a94e1dea345c8fc3d1420d3f2c7759634494ec801388edceedef8556091b7cf1bca900eb784aca91498f297a22501d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747821449"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


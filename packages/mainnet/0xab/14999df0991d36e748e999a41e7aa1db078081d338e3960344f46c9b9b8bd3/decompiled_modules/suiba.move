module 0xab14999df0991d36e748e999a41e7aa1db078081d338e3960344f46c9b9b8bd3::suiba {
    struct SUIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIBA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIBA>(arg0, b"SUIBA", b"Suibasaur", b"Just A Pokemon coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYAjACTnLtfoh2SYruR7hGBRLAS9eKyJNzt58cnFx54Pu")), b"WEBSITE", b"https://x.com/suibasaur", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00fe428c2492dc07b5ddb08c86d90e07c4d0624b9dd14d9a1596b1809157df4c6e78b726fd24eef264110b227ee2cb2745475eb8cd405e5b326808b39eedac8100d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756498"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


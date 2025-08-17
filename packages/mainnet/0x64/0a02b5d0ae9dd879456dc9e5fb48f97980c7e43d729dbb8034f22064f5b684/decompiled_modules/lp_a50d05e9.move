module 0x640a02b5d0ae9dd879456dc9e5fb48f97980c7e43d729dbb8034f22064f5b684::lp_a50d05e9 {
    struct LP_A50D05E9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_A50D05E9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_A50D05E9>(arg0, 9, b"LP-A50D05E9", b"STEAMM LP LP-A50D05E9", b"STEAMM Liquidity Provider Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_A50D05E9>>(v0, @0x863ecc02f441db0dbc4b3b15752a61dc81caa60bdee492219327feeef4df5b83);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LP_A50D05E9>>(v1, @0x863ecc02f441db0dbc4b3b15752a61dc81caa60bdee492219327feeef4df5b83);
    }

    // decompiled from Move bytecode v6
}


module 0x8d4b2f0a5f3180f738389abb233571d1317105cdb5b87a22393cda4371e80fa7::lp_coin {
    struct LP_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_COIN>(arg0, 9, b"lp_coin", b"LpCoin", b"Lp coin for CLMM pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LP_COIN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_COIN>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LP_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


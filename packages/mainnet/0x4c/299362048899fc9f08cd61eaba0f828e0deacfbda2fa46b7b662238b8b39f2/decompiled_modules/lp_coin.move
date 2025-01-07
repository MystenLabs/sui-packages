module 0x4c299362048899fc9f08cd61eaba0f828e0deacfbda2fa46b7b662238b8b39f2::lp_coin {
    struct LP_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_COIN>(arg0, 6, b"lp_coin", b"LpCoin", b"Lp coin for CLMM pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LP_COIN>(&mut v2, 900000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_COIN>>(v2, @0x9636ead2159f25e1f269223d53d51f0065915a5255fecab0ff1485ab8c64eeec);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LP_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x52c4f32cda9a6c77245673b7b46c1a94768c43ce9374579a3d12c8f51e5eff2b::lp_coin {
    struct LP_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_COIN>(arg0, 9, b"lp_coin", b"LpCoin", b"Lp coin for CLMM pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LP_COIN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_COIN>>(v2, @0x9636ead2159f25e1f269223d53d51f0065915a5255fecab0ff1485ab8c64eeec);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LP_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


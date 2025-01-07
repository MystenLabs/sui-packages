module 0xb66e9e1cd25e8be90091c4f20b42f0472ea22d4244f3bc2241891ed7ad2d80de::celer_pstake_coin {
    struct CELER_PSTAKE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CELER_PSTAKE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CELER_PSTAKE_COIN>(arg0, 9, b"PSTAKE", b"pStake Finance", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CELER_PSTAKE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CELER_PSTAKE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


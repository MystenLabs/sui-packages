module 0x36cd30e8138626d67aa62c00c8d91818ccf250456c1e9d3da17106c49bf912a6::rizztekk_coin {
    struct RIZZTEKK_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZTEKK_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZTEKK_COIN>(arg0, 6, b"RIZZ", b"RizzTekk", b"Fixed-supply coin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<RIZZTEKK_COIN>>(0x2::coin::mint<RIZZTEKK_COIN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIZZTEKK_COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RIZZTEKK_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}


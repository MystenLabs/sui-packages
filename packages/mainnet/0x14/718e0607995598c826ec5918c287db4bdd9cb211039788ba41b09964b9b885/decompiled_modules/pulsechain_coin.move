module 0x14718e0607995598c826ec5918c287db4bdd9cb211039788ba41b09964b9b885::pulsechain_coin {
    struct PULSECHAIN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PULSECHAIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PULSECHAIN_COIN>(arg0, 6, b"PLS", b"Pulsechain", b"Fixed-supply coin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PULSECHAIN_COIN>>(0x2::coin::mint<PULSECHAIN_COIN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PULSECHAIN_COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PULSECHAIN_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}


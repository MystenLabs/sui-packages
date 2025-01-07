module 0x4937565c85650cdc064619333ccbf150ac3f5302d728948dba35f24014088491::toma3610_coin {
    struct TOMA3610_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOMA3610_COIN>, arg1: 0x2::coin::Coin<TOMA3610_COIN>) {
        0x2::coin::burn<TOMA3610_COIN>(arg0, arg1);
    }

    fun init(arg0: TOMA3610_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMA3610_COIN>(arg0, 6, b"toma3610 COIN", b"toma3610 COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMA3610_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMA3610_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOMA3610_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOMA3610_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


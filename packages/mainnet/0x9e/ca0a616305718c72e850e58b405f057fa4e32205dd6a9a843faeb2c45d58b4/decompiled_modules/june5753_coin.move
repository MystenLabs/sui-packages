module 0x9eca0a616305718c72e850e58b405f057fa4e32205dd6a9a843faeb2c45d58b4::june5753_coin {
    struct JUNE5753_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JUNE5753_COIN>, arg1: 0x2::coin::Coin<JUNE5753_COIN>) {
        0x2::coin::burn<JUNE5753_COIN>(arg0, arg1);
    }

    fun init(arg0: JUNE5753_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNE5753_COIN>(arg0, 9, b"BR", b"june5753Coin", b"June5753 Coin is so cool", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUNE5753_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNE5753_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUNE5753_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JUNE5753_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


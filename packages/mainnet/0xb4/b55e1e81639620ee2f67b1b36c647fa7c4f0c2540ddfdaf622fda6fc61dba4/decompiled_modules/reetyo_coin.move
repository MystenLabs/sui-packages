module 0xb4b55e1e81639620ee2f67b1b36c647fa7c4f0c2540ddfdaf622fda6fc61dba4::reetyo_coin {
    struct REETYO_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<REETYO_COIN>, arg1: 0x2::coin::Coin<REETYO_COIN>) {
        0x2::coin::burn<REETYO_COIN>(arg0, arg1);
    }

    fun init(arg0: REETYO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REETYO_COIN>(arg0, 6, b"reetyo COIN", b"reetyo COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REETYO_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REETYO_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REETYO_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<REETYO_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


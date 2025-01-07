module 0x4b9594af47832a154fe064b36bbf55152ea66f2466536e1d9de5e50c8d8a4da1::djendjcn_coin {
    struct DJENDJCN_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DJENDJCN_COIN>, arg1: 0x2::coin::Coin<DJENDJCN_COIN>) {
        0x2::coin::burn<DJENDJCN_COIN>(arg0, arg1);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<DJENDJCN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DJENDJCN_COIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<DJENDJCN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DJENDJCN_COIN>>(0x2::coin::split<DJENDJCN_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DJENDJCN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJENDJCN_COIN>(arg0, 9, b"DJENDJCN_COIN", b"djendjcn", b"my first coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJENDJCN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJENDJCN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


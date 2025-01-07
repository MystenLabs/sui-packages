module 0xedd9b2fec64c786711b31c68a3a1db0d689b96d0745764b9a0268e42c99c359a::djendjcn_coin {
    struct DJENDJCN_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DJENDJCN_COIN>, arg1: 0x2::coin::Coin<DJENDJCN_COIN>) {
        0x2::coin::burn<DJENDJCN_COIN>(arg0, arg1);
    }

    fun init(arg0: DJENDJCN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJENDJCN_COIN>(arg0, 6, b"djendjcn COIN", b"djendjcn COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJENDJCN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJENDJCN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DJENDJCN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DJENDJCN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


module 0x5c090a46e80a50d7b11675e523a9ecfddc45637e7b0e81368dcec9e866a705e5::dirtmelon_coin {
    struct DIRTMELON_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DIRTMELON_COIN>, arg1: 0x2::coin::Coin<DIRTMELON_COIN>) {
        0x2::coin::burn<DIRTMELON_COIN>(arg0, arg1);
    }

    fun init(arg0: DIRTMELON_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIRTMELON_COIN>(arg0, 6, b"dirtmelon coin", b"dirtmelon coin", b"Awesome Coint", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIRTMELON_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIRTMELON_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DIRTMELON_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DIRTMELON_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


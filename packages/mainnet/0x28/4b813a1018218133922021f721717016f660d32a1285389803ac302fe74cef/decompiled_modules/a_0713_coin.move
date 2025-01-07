module 0x284b813a1018218133922021f721717016f660d32a1285389803ac302fe74cef::a_0713_coin {
    struct A_0713_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<A_0713_COIN>, arg1: 0x2::coin::Coin<A_0713_COIN>) {
        0x2::coin::burn<A_0713_COIN>(arg0, arg1);
    }

    fun init(arg0: A_0713_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_0713_COIN>(arg0, 6, b"a_0713 coin", b"a_0713 coin", b"Awesome Coint", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A_0713_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_0713_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<A_0713_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<A_0713_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


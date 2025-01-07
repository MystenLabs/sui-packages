module 0xb0687b83e5d37b7f3e27474ecca0a89b8871699fcd1869a845c172a56e52803d::a_1473303013_coin {
    struct A_1473303013_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<A_1473303013_COIN>, arg1: 0x2::coin::Coin<A_1473303013_COIN>) {
        0x2::coin::burn<A_1473303013_COIN>(arg0, arg1);
    }

    fun init(arg0: A_1473303013_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_1473303013_COIN>(arg0, 6, b"a_1473303013 coin", b"a_1473303013 coin", b"Awesome Coint", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A_1473303013_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_1473303013_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<A_1473303013_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<A_1473303013_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


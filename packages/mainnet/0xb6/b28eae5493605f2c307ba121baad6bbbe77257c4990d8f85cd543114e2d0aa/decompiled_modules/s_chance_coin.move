module 0xb6b28eae5493605f2c307ba121baad6bbbe77257c4990d8f85cd543114e2d0aa::s_chance_coin {
    struct S_CHANCE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<S_CHANCE_COIN>, arg1: 0x2::coin::Coin<S_CHANCE_COIN>) {
        0x2::coin::burn<S_CHANCE_COIN>(arg0, arg1);
    }

    fun init(arg0: S_CHANCE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S_CHANCE_COIN>(arg0, 6, b"s_chance COIN", b"s_chance COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S_CHANCE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S_CHANCE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<S_CHANCE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<S_CHANCE_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


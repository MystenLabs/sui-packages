module 0xcb664693219d0a498773d8313e0ef47384dfe9267c89e3acb397d4b914f5767::token_factory {
    struct TOKEN_FACTORY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN_FACTORY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN_FACTORY>>(0x2::coin::mint<TOKEN_FACTORY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TOKEN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_FACTORY>(arg0, 6, b"MY_COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_FACTORY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_FACTORY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


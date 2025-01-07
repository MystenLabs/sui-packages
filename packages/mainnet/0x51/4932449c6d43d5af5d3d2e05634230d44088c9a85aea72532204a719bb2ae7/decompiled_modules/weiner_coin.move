module 0x514932449c6d43d5af5d3d2e05634230d44088c9a85aea72532204a719bb2ae7::weiner_coin {
    struct WEINER_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WEINER_COIN>, arg1: 0x2::coin::Coin<WEINER_COIN>) {
        0x2::coin::burn<WEINER_COIN>(arg0, arg1);
    }

    fun init(arg0: WEINER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEINER_COIN>(arg0, 9, b"DICK", b"Weiner Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEINER_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEINER_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WEINER_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WEINER_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


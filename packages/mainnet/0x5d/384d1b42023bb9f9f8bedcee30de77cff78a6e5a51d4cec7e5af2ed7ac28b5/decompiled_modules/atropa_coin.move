module 0x5d384d1b42023bb9f9f8bedcee30de77cff78a6e5a51d4cec7e5af2ed7ac28b5::atropa_coin {
    struct ATROPA_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATROPA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATROPA_COIN>(arg0, 6, b"ATROPA", b"ATROPA", b"Fixed-supply coin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ATROPA_COIN>>(0x2::coin::mint<ATROPA_COIN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATROPA_COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ATROPA_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}


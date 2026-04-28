module 0xe1da7cb19cffe8ca40d6c2ae94efaf34999709313250fa3129a3a0ac29e1179::hhjj {
    struct HHJJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHJJ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HHJJ>(arg0, 9, b"HHJJ", b"mjh", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<HHJJ>>(0x2::coin::mint<HHJJ>(&mut v3, 7676000000000, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHJJ>>(v3, v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHJJ>>(v2);
    }

    // decompiled from Move bytecode v6
}


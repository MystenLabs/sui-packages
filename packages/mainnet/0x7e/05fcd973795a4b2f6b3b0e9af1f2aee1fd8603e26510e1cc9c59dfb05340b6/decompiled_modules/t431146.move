module 0x7e05fcd973795a4b2f6b3b0e9af1f2aee1fd8603e26510e1cc9c59dfb05340b6::t431146 {
    struct T431146 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T431146, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T431146>(arg0, 9, b"T431146", b"Test 431146", b"Integration test token 2025-10-19T22:53:51.146Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T431146>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T431146>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


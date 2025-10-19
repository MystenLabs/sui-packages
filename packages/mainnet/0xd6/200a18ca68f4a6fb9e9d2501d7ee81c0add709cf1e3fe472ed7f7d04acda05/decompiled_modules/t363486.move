module 0xd6200a18ca68f4a6fb9e9d2501d7ee81c0add709cf1e3fe472ed7f7d04acda05::t363486 {
    struct T363486 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T363486, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T363486>(arg0, 9, b"T363486", b"Test 363486", b"Integration test token 2025-10-19T22:52:43.486Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T363486>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T363486>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


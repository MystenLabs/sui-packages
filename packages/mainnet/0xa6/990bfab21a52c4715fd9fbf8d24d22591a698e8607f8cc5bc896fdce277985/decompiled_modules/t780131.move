module 0xa6990bfab21a52c4715fd9fbf8d24d22591a698e8607f8cc5bc896fdce277985::t780131 {
    struct T780131 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T780131, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T780131>(arg0, 9, b"T780131", b"Test 780131", b"Integration test token 2025-10-22T02:56:20.131Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T780131>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T780131>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


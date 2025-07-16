module 0x4218f3a359ffb9a25724b008d4c95f463ba88cd869193957627217aa60245125::t {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<T>(arg0, 6, b"T", b"TEST", b"Test Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/test_9933b31e81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


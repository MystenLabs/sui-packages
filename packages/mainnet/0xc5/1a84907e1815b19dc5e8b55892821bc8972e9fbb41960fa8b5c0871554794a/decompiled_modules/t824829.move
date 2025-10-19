module 0xc51a84907e1815b19dc5e8b55892821bc8972e9fbb41960fa8b5c0871554794a::t824829 {
    struct T824829 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T824829, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T824829>(arg0, 9, b"T824829", b"Test 824829", b"Integration test token 2025-10-19T22:27:04.829Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T824829>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T824829>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x67bc8d20af7a3f3ee9361b211f60a3fe3afe636462c671f2de3a3c6c51c0bf9e::t956976 {
    struct T956976 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T956976, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T956976>(arg0, 9, b"T956976", b"Test 956976", b"Integration test token 2025-10-22T02:59:16.976Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T956976>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T956976>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


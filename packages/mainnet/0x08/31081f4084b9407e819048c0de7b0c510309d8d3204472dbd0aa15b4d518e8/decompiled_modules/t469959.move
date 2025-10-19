module 0x831081f4084b9407e819048c0de7b0c510309d8d3204472dbd0aa15b4d518e8::t469959 {
    struct T469959 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T469959, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T469959>(arg0, 9, b"T469959", b"Test 469959", b"Integration test token 2025-10-19T22:54:29.960Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T469959>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T469959>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


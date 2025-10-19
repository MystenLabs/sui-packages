module 0xd105fef25739b1b116d4e2f48df281a4835c3bf8f9559f9fd49be95470906874::t030212 {
    struct T030212 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T030212, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T030212>(arg0, 9, b"T030212", b"Test 030212", b"Integration test token 2025-10-19T22:13:50.212Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T030212>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T030212>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


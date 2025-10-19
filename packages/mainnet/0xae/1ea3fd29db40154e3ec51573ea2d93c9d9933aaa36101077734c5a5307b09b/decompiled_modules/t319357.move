module 0xae1ea3fd29db40154e3ec51573ea2d93c9d9933aaa36101077734c5a5307b09b::t319357 {
    struct T319357 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T319357, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T319357>(arg0, 9, b"T319357", b"Test 319357", b"Integration test token 2025-10-19T22:51:59.357Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T319357>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T319357>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


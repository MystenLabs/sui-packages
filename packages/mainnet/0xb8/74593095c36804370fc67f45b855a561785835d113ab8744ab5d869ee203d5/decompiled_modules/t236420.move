module 0xb874593095c36804370fc67f45b855a561785835d113ab8744ab5d869ee203d5::t236420 {
    struct T236420 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T236420, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T236420>(arg0, 9, b"T236420", b"Test 236420", b"Integration test token 2025-10-19T22:50:36.420Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T236420>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T236420>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


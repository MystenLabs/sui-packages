module 0xe4679a4e08e440fd4152a2d87825b09bf32ab2d41b5a536ba103f295f000658a::t779853 {
    struct T779853 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T779853, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T779853>(arg0, 9, b"T779853", b"Test 779853", b"Integration test token 2025-10-19T22:26:19.853Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T779853>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T779853>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


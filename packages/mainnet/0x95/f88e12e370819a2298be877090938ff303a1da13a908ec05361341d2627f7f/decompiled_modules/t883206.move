module 0x95f88e12e370819a2298be877090938ff303a1da13a908ec05361341d2627f7f::t883206 {
    struct T883206 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T883206, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T883206>(arg0, 9, b"T883206", b"Test 883206", b"Integration test token 2025-10-19T22:28:03.206Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T883206>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T883206>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


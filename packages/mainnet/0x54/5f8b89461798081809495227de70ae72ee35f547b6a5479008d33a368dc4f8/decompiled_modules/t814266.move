module 0x545f8b89461798081809495227de70ae72ee35f547b6a5479008d33a368dc4f8::t814266 {
    struct T814266 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T814266, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T814266>(arg0, 9, b"T814266", b"Test 814266", b"Integration test token 2025-10-19T22:26:54.266Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T814266>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T814266>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


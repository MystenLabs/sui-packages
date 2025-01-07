module 0x3cf9db0051722f31e47b7484b37c341c9a06338aaa8936d47b1c6aaee17b8b24::artem9 {
    struct ARTEM9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTEM9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTEM9>(arg0, 10, b"ARTEM9", b"test token 321", b"test-token-321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARTEM9>(&mut v2, 90000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTEM9>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARTEM9>>(v1);
    }

    // decompiled from Move bytecode v6
}


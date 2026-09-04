module 0x46026e2aebb075614b90f8397057a8c734cba3b19d9db103adbbf59b8f202fdd::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A>(arg0, 6, b"A", b"da", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<A>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}


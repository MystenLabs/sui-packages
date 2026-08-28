module 0x1c91c9215cc50558c28d25b2dfa187179f0477c557c4c3bfd9f3af17bf9d717a::c_1 {
    struct C_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C_1>(arg0, 6, b"1", b"1", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C_1>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<C_1>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}


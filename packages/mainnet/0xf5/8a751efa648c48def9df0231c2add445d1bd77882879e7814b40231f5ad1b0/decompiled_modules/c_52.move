module 0xf58a751efa648c48def9df0231c2add445d1bd77882879e7814b40231f5ad1b0::c_52 {
    struct C_52 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C_52, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C_52>(arg0, 6, b"52", b"51", b"0.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C_52>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<C_52>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}


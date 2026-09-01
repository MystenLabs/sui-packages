module 0x2071ea2d6cf80684798b27b82be52a446459f6ab3c3736dd8441b2b2c97f5e02::c_95 {
    struct C_95 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C_95, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C_95>(arg0, 6, b"95", b"15", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C_95>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<C_95>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}


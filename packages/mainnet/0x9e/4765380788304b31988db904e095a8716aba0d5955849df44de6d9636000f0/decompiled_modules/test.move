module 0x9e4765380788304b31988db904e095a8716aba0d5955849df44de6d9636000f0::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"test by SuiAI", b"testtttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Proyecto_Quitar_fondo_2_215cd484ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


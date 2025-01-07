module 0xf8b69005e58401260301654af93f51a30948bffaa761e67139660ee9cebf935d::quantp {
    struct QUANTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTP>(arg0, 6, b"QUANTP", b"QUANT PRIME", x"536f206c6f7720616e64206869676820636f7272656374696f6e2068617070656e656420616e642073756368206120676f6f642073746f727920616e64206d656d652069742068617320746f206578706c6f64652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc2f_I_Os_XUA_Ecb71_6386cbbfa9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANTP>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xde7bb0c2aa57fec6bafd5753010f8d8564da29a134941b0400ac488180ebfc4e::slm {
    struct SLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLM>(arg0, 6, b"SLM", b"Sakana AI Agent Language Model", x"576520617265206275696c64696e67206120776f726c6420636c6173732041492052264420636f6d70616e7920696e20546f6b796f2e2057652077616e7420746f20646576656c6f7020414920736f6c7574696f6e7320666f72204a6170616e73206e656564732c20616e642064656d6f63726174697a6520414920696e204a6170616e2e2068747470733a2f2f73616b616e612e61692f636172656572730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_Owls7_DF_400x400_b2f06282b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLM>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x57081948b8377fa7fdd4384d2bf191bbdd42c2dd7339407ddd5d5d2e3344e90c::d01f1n {
    struct D01F1N has drop {
        dummy_field: bool,
    }

    fun init(arg0: D01F1N, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D01F1N>(arg0, 6, b"D01F1N", b"D01-F1N on $SUI", x"4372617a792061737320726f626f20646f6c7068696e2065766f6c7665642066726f6d20756e64657267726f756e642024535549206f7065726174696f6e732c206573636170656420696e746f2074686520776f726c642e0a546869732069732068697320646f6d61696e206e6f772e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_d2ceeead9f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D01F1N>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<D01F1N>>(v1);
    }

    // decompiled from Move bytecode v6
}


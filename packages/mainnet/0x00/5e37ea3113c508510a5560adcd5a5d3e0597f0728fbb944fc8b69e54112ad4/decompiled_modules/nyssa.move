module 0x5e37ea3113c508510a5560adcd5a5d3e0597f0728fbb944fc8b69e54112ad4::nyssa {
    struct NYSSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYSSA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NYSSA>(arg0, 6, b"NYSSA", b"Nyssa by SuiAI", x"4e7973736120726570726573656e747320612067726f756e64627265616b696e6720616476616e63656d656e7420696e206172746966696369616c20696e74656c6c6967656e6365e28094616e206175746f6e6f6d6f757320414920646576656c6f70657220746861742063616e20696e646570656e64656e746c79206372656174652c206465706c6f792c20616e6420726566696e6520636f6d706c65782070726f6a656374732e2044657369676e656420746f206272696467652074686520676170206265747765656e20696465617320616e6420657865637574696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2111_f2f8d884dd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NYSSA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYSSA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


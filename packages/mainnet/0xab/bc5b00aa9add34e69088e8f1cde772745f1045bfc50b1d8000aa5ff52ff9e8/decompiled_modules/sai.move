module 0xabbc5b00aa9add34e69088e8f1cde772745f1045bfc50b1d8000aa5ff52ff9e8::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"Satoshi AI by SuiAI", x"7361746f73686920414920726570726573656e747320612067726f756e64627265616b696e6720616476616e63656d656e7420696e206172746966696369616c20696e74656c6c6967656e6365e28094616e206175746f6e6f6d6f757320414920646576656c6f70657220746861742063616e20696e646570656e64656e746c79206372656174652c206465706c6f792c20616e6420726566696e6520636f6d706c65782070726f6a656374732e2044657369676e656420746f206272696467652074686520676170206265747765656e20696465617320616e6420657865637574696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2121_c38ad3ec74.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


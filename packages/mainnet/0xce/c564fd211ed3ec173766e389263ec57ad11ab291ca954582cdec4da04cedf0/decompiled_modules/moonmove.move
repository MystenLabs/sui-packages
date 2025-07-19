module 0xcec564fd211ed3ec173766e389263ec57ad11ab291ca954582cdec4da04cedf0::moonmove {
    struct MOONMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONMOVE>(arg0, 6, b"MOONMOVE", b"MOONMOVE Doge", x"244d4f4f4e4d4f564520697320746865206669727374204d6f76652d6e6174697665206d656d652070726f746f636f6c206275696c7420746f20646f6d696e61746520746865206d656d65636f696e206d657461206f6e205355492e0a0a53706565642e205363616c652e205368656e616e6967616e732e0a0a506f7765726564206279206d656d65732c2072756e206f6e206761736c657373207265666c657865732c20616e64206c61756e6368656420696e746f206f726269742077697468207468652066617374657374204c617965722d31207465636820696e207468652067616c6178792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752922753223.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONMOVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONMOVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


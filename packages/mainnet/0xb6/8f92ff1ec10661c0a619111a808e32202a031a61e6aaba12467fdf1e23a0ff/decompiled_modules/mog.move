module 0xb68f92ff1ec10661c0a619111a808e32202a031a61e6aaba12467fdf1e23a0ff::mog {
    struct MOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOG>(arg0, 6, b"MOG", b"8-BIT MOG", x"20382d426974204d6f67207c204275696c64206f6e20537569200a0a2054686520382d6269742076657273696f6e206f6620746865204d4f47206d656d6520636f696e2061646473206120706c617966756c2c20726574726f207477697374207769746820636c617373696320706978656c206172742c206272696e67696e67206261636b20746865206f6c642d7363686f6f6c20766964656f2067616d6520766962652e0a0a2046697273742067616d6520706c6179206f6e2053554921200a2d20506c61792068657265203a2047616d6520382d426974204d6f67202d2068747470733a2f2f67616d652e386269746d6f672e78797a2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_bitmeow_2f86146f55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


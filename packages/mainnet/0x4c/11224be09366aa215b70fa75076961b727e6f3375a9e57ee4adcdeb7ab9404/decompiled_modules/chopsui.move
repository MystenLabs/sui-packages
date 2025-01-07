module 0x4c11224be09366aa215b70fa75076961b727e6f3375a9e57ee4adcdeb7ab9404::chopsui {
    struct CHOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPSUI>(arg0, 6, b"CHOPSUI", b"Chop Sui", x"43686f702053756579204973204d6574616c2e2024535549204973204d6574616c2e20546f67657468657220576520476f74202443484f505355492e204e6f7720546861742773204672696767696e204d6574616c2120534f4144204973204f6e65204f662054686520474f4154732e0a0a4465782050726f66696c65204174203135306b2c204465762061696e742072756767696e2c206e6f202764656e792720666561747572652c206e6f20276d696e742720666561747572652e206a75737420676f6f64202443484f505355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734129579933.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHOPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


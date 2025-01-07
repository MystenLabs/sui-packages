module 0x510def72e606780c95147ca6f9a0d94532265173e265e375d5d76654d7a00642::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"SUIP", x"53756950616420f09f8c8a", x"e28ca0546865205072656d696572204c61756e636870616420666f72205469657220312050726f6a656374732e200a0a42652074686520666972737420746f206f776e20746865206675747572652e0a506f7765726564206279200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956556872.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


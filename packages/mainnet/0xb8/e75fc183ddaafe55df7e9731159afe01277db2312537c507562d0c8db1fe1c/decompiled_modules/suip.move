module 0xb8e75fc183ddaafe55df7e9731159afe01277db2312537c507562d0c8db1fe1c::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"SUIP", b"Sui-Launchpad", x"546865205072656d696572204c61756e636870616420666f72205469657220312050726f6a656374732e200a0a42652074686520666972737420746f206f776e20746865206675747572652e0a0a506f7765726564206279203a2020405375694e6574776f726b20f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958125050.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


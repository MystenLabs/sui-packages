module 0xbe64be4d2a906a19ea0720fa0cc9934940b3b0b5728f2d97d1fba69c024bb051::joetrump {
    struct JOETRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOETRUMP>(arg0, 9, b"JOETRUMP", b"Rogan and ", b"Rogan and Trump broke the internet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b909436f-7095-479a-85df-70f1ece3cc37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOETRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOETRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


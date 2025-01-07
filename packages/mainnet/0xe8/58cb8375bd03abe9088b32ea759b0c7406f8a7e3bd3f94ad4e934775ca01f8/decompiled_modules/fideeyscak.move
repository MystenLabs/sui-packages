module 0xe858cb8375bd03abe9088b32ea759b0c7406f8a7e3bd3f94ad4e934775ca01f8::fideeyscak {
    struct FIDEEYSCAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIDEEYSCAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIDEEYSCAK>(arg0, 9, b"FIDEEYSCAK", b"MDAIB", b"Only Me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/decf6d38-b08d-46a2-bca1-2af6067914f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIDEEYSCAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIDEEYSCAK>>(v1);
    }

    // decompiled from Move bytecode v6
}


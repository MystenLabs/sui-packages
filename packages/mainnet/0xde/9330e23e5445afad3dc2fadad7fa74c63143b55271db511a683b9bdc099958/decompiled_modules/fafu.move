module 0xde9330e23e5445afad3dc2fadad7fa74c63143b55271db511a683b9bdc099958::fafu {
    struct FAFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAFU>(arg0, 9, b"FAFU", b"Fafafufu", b"www.fafu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89bed77f-ada5-4d0b-b1ce-f10adc398424.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAFU>>(v1);
    }

    // decompiled from Move bytecode v6
}


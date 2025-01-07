module 0xb64cd7ee12e40aff3bfb389556b44b29dc46a63f1ecf73ebc8205de69ed1efa8::ketawamen {
    struct KETAWAMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETAWAMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETAWAMEN>(arg0, 9, b"KETAWAMEN", b"Ketawa men", b"Orang ketawa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47aff9a1-b3d2-4c25-9cfd-b32929d69cd0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETAWAMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KETAWAMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


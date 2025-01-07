module 0x8d90218ff54a2c3bc7f44a8e87682b009edf0c6574bd7ed56681267367afc28::bgbgbg {
    struct BGBGBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGBGBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGBGBG>(arg0, 9, b"BGBGBG", b"GBBGBG", b"BGBGBGBGBG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a151e0c5-fad4-4396-8954-ec919dbc216e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGBGBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGBGBG>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xeb2a877a9d97fd7707e980b67f026eecb07519d95370639f88f1eca565d704de::major {
    struct MAJOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAJOR>(arg0, 9, b"MAJOR", b"$MAJOR", x"4265636f6d652061204d616a6f72206f662054656c656772616d2e20244d414a4f5220746f6b656e2072656c65617365206f6e207375692e200a0a4f6666696369616c206368616e6e656c3a204073746172736d616a6f722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a949e825-12da-470c-b28c-17339ab3695a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAJOR>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xf8f797d4b3b097b87993cfcc88f2affc9ae6a2c131d72b9b15ca1d50d9857ba3::tone_token {
    struct TONE_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONE_TOKEN>(arg0, 9, b"TONE_TOKEN", b"Tone", b"Tone Token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85b6332f-9846-415f-99b1-ea656442ada0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONE_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONE_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


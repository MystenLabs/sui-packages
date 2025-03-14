module 0xa3dc399d08ef7d235d0b5dd01dc583a39d0f1cabc02e50c199fa626ee401b758::wav {
    struct WAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAV>(arg0, 9, b"WAV", b"W.Collect", b"Romeo86", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f1a866f-8290-444b-b0c9-ee4ce0f68e80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAV>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x462f7e052b3c4d8c1e7cb677bee82c87ad6216b8b194a769fbcc8cc861ce2299::wav {
    struct WAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAV>(arg0, 9, b"WAV", b"Wave", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10f68e1b-e562-42d9-a3b3-b72eba1e4b9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAV>>(v1);
    }

    // decompiled from Move bytecode v6
}


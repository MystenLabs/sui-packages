module 0x5873e19e3005b303140029d449ac8b28cece06faa5baaa2806037c37f9a4c19a::wav {
    struct WAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAV>(arg0, 9, b"WAV", b" WAVE", b"s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81998ac5-f025-4c4f-890a-4bb35b8d52db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAV>>(v1);
    }

    // decompiled from Move bytecode v6
}


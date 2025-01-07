module 0xc1c7629dec83e2a1be6c38c9f39fa2dbbfdcdd62ad873cd8c696295171caecc5::tailer {
    struct TAILER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAILER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAILER>(arg0, 9, b"TAILER", b"Tailer dog", b"Tailerdog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f07b457d-d9e3-4640-baed-ca66801d1b80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAILER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAILER>>(v1);
    }

    // decompiled from Move bytecode v6
}


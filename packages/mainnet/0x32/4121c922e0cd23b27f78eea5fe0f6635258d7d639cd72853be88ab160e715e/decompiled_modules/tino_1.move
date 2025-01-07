module 0x324121c922e0cd23b27f78eea5fe0f6635258d7d639cd72853be88ab160e715e::tino_1 {
    struct TINO_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINO_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINO_1>(arg0, 9, b"TINO_1", b"Tino", b"For Tino and for Tino", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea982681-0b0a-491e-95ea-b9cac7251e03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINO_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TINO_1>>(v1);
    }

    // decompiled from Move bytecode v6
}


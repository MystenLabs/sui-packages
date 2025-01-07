module 0x51f500c7c388b0887b2b1a0326e176e62d301d654dbfd05586dbd9f22d66291f::dt {
    struct DT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DT>(arg0, 9, b"DT", b"Dicert ", b"Transfer meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8452ea24-07e4-4a58-a5cb-4bf21bd3cdfe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DT>>(v1);
    }

    // decompiled from Move bytecode v6
}


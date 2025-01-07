module 0x98ec08ea8bb84de8627a54592aeb1ca904697c4429f8667af84b3733726d88df::aaim {
    struct AAIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAIM>(arg0, 9, b"AAIM", b"Imina", b"Good geta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e7cca29-9dd5-487a-bc06-8b31dafb1a72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAIM>>(v1);
    }

    // decompiled from Move bytecode v6
}


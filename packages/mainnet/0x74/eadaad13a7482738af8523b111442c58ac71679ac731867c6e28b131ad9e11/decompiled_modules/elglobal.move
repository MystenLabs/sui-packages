module 0x74eadaad13a7482738af8523b111442c58ac71679ac731867c6e28b131ad9e11::elglobal {
    struct ELGLOBAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELGLOBAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELGLOBAL>(arg0, 9, b"ELGLOBAL", b"Elitglobal", b"Elite global adalah token yang bikin hodler auto JP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce95bcea-efd7-4bfa-8d89-2a4d87c64d45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELGLOBAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELGLOBAL>>(v1);
    }

    // decompiled from Move bytecode v6
}


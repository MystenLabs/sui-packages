module 0x7633db356f8e2df6fb38704aaefe708578f5a7dee64cabd53b1a2f91de5a83d::trader13 {
    struct TRADER13 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRADER13, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRADER13>(arg0, 9, b"TRADER13", b"13", b"Trading & Signal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb6a88df-2683-43d1-95c7-633d32b7d3eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRADER13>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRADER13>>(v1);
    }

    // decompiled from Move bytecode v6
}


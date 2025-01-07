module 0x584b0e11ebc4d86441b77ef2b263918d8688adcdc4887d4c014dcbcf00032567::gtq {
    struct GTQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTQ>(arg0, 9, b"GTQ", b"GTQuant", b"Gen to QUANT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2c1bb23-5ab7-4cdb-a2aa-661761bcaf97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTQ>>(v1);
    }

    // decompiled from Move bytecode v6
}


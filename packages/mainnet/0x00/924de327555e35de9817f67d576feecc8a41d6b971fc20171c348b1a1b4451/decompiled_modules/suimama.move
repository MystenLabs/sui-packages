module 0x924de327555e35de9817f67d576feecc8a41d6b971fc20171c348b1a1b4451::suimama {
    struct SUIMAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAMA>(arg0, 9, b"SUIMAMA", b"Suimaam", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/920dda7b-d0f0-48da-b4bb-7bbeea0cbb70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}


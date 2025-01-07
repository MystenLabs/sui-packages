module 0x56694ed262fd629adcfec0393c71ae504948c6b461bbe09c20e137d9beda9fb::jayadi {
    struct JAYADI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAYADI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAYADI>(arg0, 9, b"JAYADI", b"Jadi", b"Jaydiabs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/784770f6-f870-40c4-b7ca-e9f0c86f9b86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAYADI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAYADI>>(v1);
    }

    // decompiled from Move bytecode v6
}


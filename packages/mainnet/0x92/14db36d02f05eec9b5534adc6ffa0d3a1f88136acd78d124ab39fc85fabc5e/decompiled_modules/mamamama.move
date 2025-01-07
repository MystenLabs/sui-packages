module 0x9214db36d02f05eec9b5534adc6ffa0d3a1f88136acd78d124ab39fc85fabc5e::mamamama {
    struct MAMAMAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMAMAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMAMAMA>(arg0, 9, b"MAMAMAMA", b"Mama", b"Mama!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c367e156-1214-4ca3-aba1-5a528c51caaa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMAMAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMAMAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}


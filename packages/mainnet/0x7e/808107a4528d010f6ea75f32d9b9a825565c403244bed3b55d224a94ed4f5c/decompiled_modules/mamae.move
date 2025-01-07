module 0x7e808107a4528d010f6ea75f32d9b9a825565c403244bed3b55d224a94ed4f5c::mamae {
    struct MAMAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMAE>(arg0, 9, b"MAMAE", b"MAMAMI", b"MOTHER I LOVE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2677535a-7cf1-4b2a-8a80-ed60f5b2b84f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMAE>>(v1);
    }

    // decompiled from Move bytecode v6
}


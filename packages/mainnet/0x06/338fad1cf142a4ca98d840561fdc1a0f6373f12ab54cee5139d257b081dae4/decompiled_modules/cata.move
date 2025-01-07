module 0x6338fad1cf142a4ca98d840561fdc1a0f6373f12ab54cee5139d257b081dae4::cata {
    struct CATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATA>(arg0, 9, b"CATA", b"dayo akina", b"I love cats ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86f3b36b-5fbd-4af2-a5f4-e8311565eaa1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATA>>(v1);
    }

    // decompiled from Move bytecode v6
}


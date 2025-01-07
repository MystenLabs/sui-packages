module 0x9f6f2ed9012deb8672c78179f4cc9e4e695694174d252a4421a5ab052f792f9::wejani {
    struct WEJANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEJANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEJANI>(arg0, 9, b"WEJANI", b"JANI", b"JANI is a love story ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/675dad8e-96ba-4bc8-9a0b-3aca8f5a65b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEJANI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEJANI>>(v1);
    }

    // decompiled from Move bytecode v6
}


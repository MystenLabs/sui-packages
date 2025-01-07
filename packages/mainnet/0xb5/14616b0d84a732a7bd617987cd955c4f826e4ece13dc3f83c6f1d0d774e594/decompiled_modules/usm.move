module 0xb514616b0d84a732a7bd617987cd955c4f826e4ece13dc3f83c6f1d0d774e594::usm {
    struct USM has drop {
        dummy_field: bool,
    }

    fun init(arg0: USM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USM>(arg0, 9, b"USM", b"Usman", b"Usmtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c53bf909-eb48-4333-bde6-a93c59beda3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USM>>(v1);
    }

    // decompiled from Move bytecode v6
}


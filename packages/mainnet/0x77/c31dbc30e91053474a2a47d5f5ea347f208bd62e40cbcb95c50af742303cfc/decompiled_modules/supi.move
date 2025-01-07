module 0x77c31dbc30e91053474a2a47d5f5ea347f208bd62e40cbcb95c50af742303cfc::supi {
    struct SUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPI>(arg0, 9, b"SUPI", b"SUIPANDA", b" dives into the digital seas of the Sui network, hunting shiny Sui coinsWearing a diving maskhe chases them like fish, collecting each in his digital treasure chest Known as the best coin hunter SUPI proves that patience and humor win the", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b64ce74d-4c58-4986-b09e-80474a0f476f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPI>>(v1);
    }

    // decompiled from Move bytecode v6
}


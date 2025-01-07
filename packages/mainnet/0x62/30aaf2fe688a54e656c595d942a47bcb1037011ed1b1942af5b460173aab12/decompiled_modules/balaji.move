module 0x6230aaf2fe688a54e656c595d942a47bcb1037011ed1b1942af5b460173aab12::balaji {
    struct BALAJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALAJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALAJI>(arg0, 9, b"BALAJI", b"Salasar", b"Salasar Balaji Temple Charitable Trust ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc06c33b-6b2c-445d-90a6-8344cd811c8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALAJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALAJI>>(v1);
    }

    // decompiled from Move bytecode v6
}


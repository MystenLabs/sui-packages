module 0x967d10c41c2947d80bfc7fb795e51383759819130a692d5f83c90a7f8cdffafe::nqsssd {
    struct NQSSSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NQSSSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NQSSSD>(arg0, 9, b"NQSSSD", b"Pi", b"Djdjcokejskdjd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb540188-aaf9-48c5-be82-12207921ecaa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NQSSSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NQSSSD>>(v1);
    }

    // decompiled from Move bytecode v6
}


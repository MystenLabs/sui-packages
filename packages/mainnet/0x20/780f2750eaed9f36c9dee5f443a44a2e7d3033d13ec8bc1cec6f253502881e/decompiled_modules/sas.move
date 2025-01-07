module 0x20780f2750eaed9f36c9dee5f443a44a2e7d3033d13ec8bc1cec6f253502881e::sas {
    struct SAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAS>(arg0, 9, b"SAS", b"Aras", b"IRAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d475b812-a5f4-4176-9401-9160aa4d17d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAS>>(v1);
    }

    // decompiled from Move bytecode v6
}


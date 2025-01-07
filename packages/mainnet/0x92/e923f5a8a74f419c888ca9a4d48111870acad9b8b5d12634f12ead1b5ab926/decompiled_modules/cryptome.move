module 0x92e923f5a8a74f419c888ca9a4d48111870acad9b8b5d12634f12ead1b5ab926::cryptome {
    struct CRYPTOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTOME>(arg0, 9, b"CRYPTOME", b"Memoe", x"4368c3a16e206368c3a16e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16af9577-c9af-4bbd-a1e1-e69f23780bac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPTOME>>(v1);
    }

    // decompiled from Move bytecode v6
}


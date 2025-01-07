module 0xe68d4c3d622c31702efd7f65b4c7d3adbef06ed2b45fa90f7a97ab10e63b2326::sjsh {
    struct SJSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJSH>(arg0, 9, b"SJSH", b"Snsn", b"Sjshb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef6b4310-30c7-432c-9b18-625ab0eae8a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJSH>>(v1);
    }

    // decompiled from Move bytecode v6
}


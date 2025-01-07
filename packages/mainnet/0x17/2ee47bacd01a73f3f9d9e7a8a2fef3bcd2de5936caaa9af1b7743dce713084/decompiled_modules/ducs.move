module 0x172ee47bacd01a73f3f9d9e7a8a2fef3bcd2de5936caaa9af1b7743dce713084::ducs {
    struct DUCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCS>(arg0, 9, b"DUCS", b"Duchss", b"Meme aupper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc350f56-820e-49a2-ad29-6e19b9768b19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCS>>(v1);
    }

    // decompiled from Move bytecode v6
}


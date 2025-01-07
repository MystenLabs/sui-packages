module 0x2250336f06ab5098cc3601c7e0a20f80827cc71ef727364241154ead71d7a5b4::dosto {
    struct DOSTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSTO>(arg0, 9, b"DOSTO", b"Fyodor", b"FyodorDostoevsky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8bf214d-b159-4d78-ac63-615f1c34f46e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOSTO>>(v1);
    }

    // decompiled from Move bytecode v6
}


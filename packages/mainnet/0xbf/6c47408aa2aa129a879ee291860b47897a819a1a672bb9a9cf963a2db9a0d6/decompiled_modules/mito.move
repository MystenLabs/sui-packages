module 0xbf6c47408aa2aa129a879ee291860b47897a819a1a672bb9a9cf963a2db9a0d6::mito {
    struct MITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MITO>(arg0, 9, b"MITO", b"Mito Token", b"token community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9823033c-5249-4c86-b950-4fa034b09921.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MITO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xb2e4c34282bc2d81b08c7a48b1ac6cf9137e0f9c625e8f6c807d8cb11cfc0301::webabyuni {
    struct WEBABYUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEBABYUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEBABYUNI>(arg0, 9, b"WEBABYUNI", b"Babyuni", b"Babyuni is a legendary figure, the God Son who protect the world from the evil. So In memorial of the God Son we introduce this coin to bring the peace in this world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e597b06-37e5-40dd-a5f2-04b9b646bfc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEBABYUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEBABYUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x6b2677e5c652545d7881397c14b938633d9915c4f384e7766b26a0aa79468629::kica {
    struct KICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KICA>(arg0, 9, b"KICA", b"Kica", b"Desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67d76b98-ecaf-4d01-a78b-925846b55074.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KICA>>(v1);
    }

    // decompiled from Move bytecode v6
}


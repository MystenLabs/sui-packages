module 0xd9ac572df6c72e3aeab6797b77841c8f6ef1556e6c8b9e90e1fdcaf964c6b9b0::ketc {
    struct KETC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETC>(arg0, 9, b"KETC", b"Ketchuki", b"FASION TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f03eecc0-198e-41b0-8774-77ffe7423fcf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KETC>>(v1);
    }

    // decompiled from Move bytecode v6
}


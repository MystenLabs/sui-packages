module 0xfdb6bd4daed036e95c889592f5d15db5c3cfda07f2f44b64fe1fa1a6f266bd1b::haki {
    struct HAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAKI>(arg0, 9, b"HAKI", b"Hakimim", b"Hakimim is haki meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56a90b11-650f-4339-8618-edf7ee049510.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}


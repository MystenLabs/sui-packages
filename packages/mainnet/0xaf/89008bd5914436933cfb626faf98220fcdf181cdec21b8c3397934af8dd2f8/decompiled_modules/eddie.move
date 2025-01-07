module 0xaf89008bd5914436933cfb626faf98220fcdf181cdec21b8c3397934af8dd2f8::eddie {
    struct EDDIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDDIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDDIE>(arg0, 9, b"EDDIE", b"Fab", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43e7bd0e-6b17-420d-8d5c-b8ca99bf2b31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDDIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDDIE>>(v1);
    }

    // decompiled from Move bytecode v6
}


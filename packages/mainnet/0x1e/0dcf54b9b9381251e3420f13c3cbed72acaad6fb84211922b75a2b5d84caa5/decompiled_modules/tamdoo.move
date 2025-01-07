module 0x1e0dcf54b9b9381251e3420f13c3cbed72acaad6fb84211922b75a2b5d84caa5::tamdoo {
    struct TAMDOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMDOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMDOO>(arg0, 9, b"TAMDOO", b"TAMDO", b"TAMDO is king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a263c75-cda2-41dd-8651-b94b7e0f2de4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMDOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAMDOO>>(v1);
    }

    // decompiled from Move bytecode v6
}


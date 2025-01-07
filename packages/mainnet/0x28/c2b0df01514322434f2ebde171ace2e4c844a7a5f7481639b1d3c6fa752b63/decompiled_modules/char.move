module 0x28c2b0df01514322434f2ebde171ace2e4c844a7a5f7481639b1d3c6fa752b63::char {
    struct CHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAR>(arg0, 9, b"CHAR", b"Charentais", b"Charentaise lande ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/640a87bc-5324-4ce2-8570-78a2130d6602.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


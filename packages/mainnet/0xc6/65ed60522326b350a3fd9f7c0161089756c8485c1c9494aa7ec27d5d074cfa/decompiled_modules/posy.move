module 0xc665ed60522326b350a3fd9f7c0161089756c8485c1c9494aa7ec27d5d074cfa::posy {
    struct POSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSY>(arg0, 9, b"POSY", b"Positive ", b"Nya ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a695def-40cc-4cea-a84e-4a3a081373c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POSY>>(v1);
    }

    // decompiled from Move bytecode v6
}


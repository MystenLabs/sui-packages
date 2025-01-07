module 0x3f94bee2d0ed0b4958e1aaf21cd563e1b5f37f5b09876834a2015ab656ecb07c::lukita {
    struct LUKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUKITA>(arg0, 9, b"LUKITA", b"Luka Modri", b"Luka Modric MT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d1da594-9ee1-40d2-b3a7-281f7a8cc8b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUKITA>>(v1);
    }

    // decompiled from Move bytecode v6
}


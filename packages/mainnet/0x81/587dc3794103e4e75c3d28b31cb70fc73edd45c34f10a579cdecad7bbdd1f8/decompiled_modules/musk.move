module 0x81587dc3794103e4e75c3d28b31cb70fc73edd45c34f10a579cdecad7bbdd1f8::musk {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSK>(arg0, 6, b"Musk", b"musk", b"MuskCoin is inspired by one of the most incredible engineers of the modern world -Elon Musk. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731044626386.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


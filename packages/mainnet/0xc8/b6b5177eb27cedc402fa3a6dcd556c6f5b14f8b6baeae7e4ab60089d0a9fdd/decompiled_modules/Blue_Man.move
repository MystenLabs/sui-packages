module 0xc8b6b5177eb27cedc402fa3a6dcd556c6f5b14f8b6baeae7e4ab60089d0a9fdd::Blue_Man {
    struct BLUE_MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE_MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE_MAN>(arg0, 9, b"BM", b"Blue Man", b"im blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz7GEuPbkAAv1uy?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUE_MAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE_MAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


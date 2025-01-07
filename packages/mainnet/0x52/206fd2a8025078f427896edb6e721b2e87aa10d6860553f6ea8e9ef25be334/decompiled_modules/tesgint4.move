module 0x52206fd2a8025078f427896edb6e721b2e87aa10d6860553f6ea8e9ef25be334::tesgint4 {
    struct TESGINT4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESGINT4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESGINT4>(arg0, 6, b"Tesgint4", b"Tesgin4", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732594989529.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESGINT4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESGINT4>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


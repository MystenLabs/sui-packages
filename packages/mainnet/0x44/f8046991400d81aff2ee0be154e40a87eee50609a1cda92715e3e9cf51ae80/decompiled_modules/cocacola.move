module 0x44f8046991400d81aff2ee0be154e40a87eee50609a1cda92715e3e9cf51ae80::cocacola {
    struct COCACOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCACOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCACOLA>(arg0, 6, b"COCACOLA", b"Wikipedia Coca-Cola", b"Wikipedia Coca-Cola | #Just4Fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731610383795.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCACOLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCACOLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x88aa49232d6b3276fbd1f8a106bf34804a02b997ff41f946e8f80776f90d739d::GSUI {
    struct GSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSUI>(arg0, 9, b"GSUI", b"GSUI", b"GSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


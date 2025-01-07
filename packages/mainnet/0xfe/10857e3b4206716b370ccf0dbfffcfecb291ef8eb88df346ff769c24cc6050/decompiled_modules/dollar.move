module 0xfe10857e3b4206716b370ccf0dbfffcfecb291ef8eb88df346ff769c24cc6050::dollar {
    struct DOLLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLAR>(arg0, 6, b"Dollar", b"Scrooge McDuck", b"the richest duck on #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731874442733.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLLAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


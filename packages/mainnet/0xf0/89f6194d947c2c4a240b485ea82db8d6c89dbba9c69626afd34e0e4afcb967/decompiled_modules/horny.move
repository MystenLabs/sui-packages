module 0xf089f6194d947c2c4a240b485ea82db8d6c89dbba9c69626afd34e0e4afcb967::horny {
    struct HORNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORNY>(arg0, 6, b"HORNY", b"HORNY SUI", b"SHUT UP AND TAKE MY MONEY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_rh_Pi_Lo_400x400_25a12126ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORNY>>(v1);
    }

    // decompiled from Move bytecode v6
}


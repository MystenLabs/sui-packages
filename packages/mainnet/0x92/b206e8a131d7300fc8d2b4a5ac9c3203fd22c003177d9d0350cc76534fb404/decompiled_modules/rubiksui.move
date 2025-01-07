module 0x92b206e8a131d7300fc8d2b4a5ac9c3203fd22c003177d9d0350cc76534fb404::rubiksui {
    struct RUBIKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUBIKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUBIKSUI>(arg0, 6, b"RUBIKSUI", b"RUBIKS", b"THE NEW CREATION OF SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rubik_p_69db357d18.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUBIKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUBIKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


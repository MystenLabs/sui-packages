module 0xaec7ec434b0870fc8e6b0e7af82b7f43c0b93d40f8b6fa4e1451ada0cb2141b7::suino {
    struct SUINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINO>(arg0, 6, b"Suino", b"Suino the pig", b"Suino the pig on sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000248167_69cdd41be1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xdc855bc3863f0b7b66739dc331ff8d332b0047edbf2c4b02bbe307c3a890b44c::champagnepipi {
    struct CHAMPAGNEPIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMPAGNEPIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMPAGNEPIPI>(arg0, 6, b"ChampagnePipi", b"Back shot Drake", b"Welcome to the world of Diddy! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000073716_a0c4a1ed4c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMPAGNEPIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAMPAGNEPIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}


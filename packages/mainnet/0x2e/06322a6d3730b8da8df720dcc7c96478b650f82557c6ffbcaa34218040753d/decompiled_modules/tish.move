module 0x2e06322a6d3730b8da8df720dcc7c96478b650f82557c6ffbcaa34218040753d::tish {
    struct TISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TISH>(arg0, 6, b"Tish", b"TardFish", b"Just a retarded fish ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tard_Fish_ac859f2dc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TISH>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xa3d93b037115855b47c22856a71abf9ebfbb4a7933b91438ca2c98d85c4b2827::marbles {
    struct MARBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARBLES>(arg0, 6, b"MARBLES", b"Marble Saga", x"4120576562332047616d6520506f7765726564206279205355492e20506c617920596f7572204d6172626c657320616e64204561726e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_25_13_50_55_67454ad397.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}


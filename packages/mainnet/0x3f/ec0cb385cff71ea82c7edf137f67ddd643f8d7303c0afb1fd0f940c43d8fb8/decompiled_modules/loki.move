module 0x3fec0cb385cff71ea82c7edf137f67ddd643f8d7303c0afb1fd0f940c43d8fb8::loki {
    struct LOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOKI>(arg0, 9, b"LOKI", b"LOKI", b"Something majestic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images-cdn.9gag.com/photo/aYYwXQN_700b.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOKI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}


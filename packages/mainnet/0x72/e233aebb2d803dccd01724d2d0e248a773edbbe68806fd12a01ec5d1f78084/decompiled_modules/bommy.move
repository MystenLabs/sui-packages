module 0x72e233aebb2d803dccd01724d2d0e248a773edbbe68806fd12a01ec5d1f78084::bommy {
    struct BOMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMMY>(arg0, 9, b"BOMMY", b"BOMMY", b"egggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"0xc55405ef48206d3cb6ef9ee8c312a5208c7176ca452c78eb31c294322a773485")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOMMY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMMY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x61193111f2ff1bb4a5f29a4f126b1fdd06fa8e53cd3cf95a5503053adbea6453::gotomoon {
    struct GOTOMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOTOMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOTOMOON>(arg0, 6, b"GOTOMOON", b"GO TO MOON", x"474f20544f204d4f4f4e2050524f4a45435420495320414e204152544946494349414c20494e54454c4c4947454e43452d504f574552454420504958454c204d454d4520434f494e2047454e45524154494f4e2050524f4a4543542e205448524f554748205448452041475245454d454e54532057452057494c4c204d414b452c2057452057494c4c20435245415445204144564552544953494e47204944532c204e46545320414e44204144564552544953494e4720494453204f4620434f4d4d554e495449455320544841542057414e5420544f204d494e45204d454d4520434f494e532ef09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963114845.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOTOMOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTOMOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


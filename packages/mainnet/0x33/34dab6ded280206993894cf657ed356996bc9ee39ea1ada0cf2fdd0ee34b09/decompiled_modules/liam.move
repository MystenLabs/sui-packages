module 0x3334dab6ded280206993894cf657ed356996bc9ee39ea1ada0cf2fdd0ee34b09::liam {
    struct LIAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIAM>(arg0, 9, b"LIAM", b"LiamCoin", b"A test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIAM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIAM>>(v1);
    }

    // decompiled from Move bytecode v6
}


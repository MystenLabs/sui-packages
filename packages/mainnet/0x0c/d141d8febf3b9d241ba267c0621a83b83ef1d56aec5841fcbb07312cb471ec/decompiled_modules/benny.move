module 0xcd141d8febf3b9d241ba267c0621a83b83ef1d56aec5841fcbb07312cb471ec::benny {
    struct BENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENNY>(arg0, 9, b"BENNY", b"BennyTheBull", b"Why SUI doesn't have a mascot? Let's fill this gap together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BENNY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENNY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}


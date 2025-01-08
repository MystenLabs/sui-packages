module 0x158e70fa7e03afbd1b8236339e0f8b7c0f5eb2c131799792b0a9cf428d8df6a3::bethhhh {
    struct BETHHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETHHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETHHHH>(arg0, 9, b"BETHHHH", b"BETHHH", b"S", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BETHHHH>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETHHHH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETHHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}


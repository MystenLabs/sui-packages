module 0xd5ee1187efe33721265717165a0815a841bc2db19293d8510b9190fa4efdffc0::usdb {
    struct USDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDB>(arg0, 9, b"USDB", b"USDB", b"111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDB>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDB>>(v1);
    }

    // decompiled from Move bytecode v6
}


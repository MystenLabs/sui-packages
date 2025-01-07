module 0x8fb29ba9fe9a9350bb50fd60e6a23a04df241bdcc3cd6eb03d9c7dfb717dd9b1::saga {
    struct SAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGA>(arg0, 1, b"SAGA", b"SAGA", b"Saint Galler", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAGA>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}


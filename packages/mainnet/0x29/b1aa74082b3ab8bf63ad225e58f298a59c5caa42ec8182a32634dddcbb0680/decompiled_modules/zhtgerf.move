module 0x29b1aa74082b3ab8bf63ad225e58f298a59c5caa42ec8182a32634dddcbb0680::zhtgerf {
    struct ZHTGERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZHTGERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHTGERF>(arg0, 6, b"zhtgerf", b"zhtgerf", b"erd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZHTGERF>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHTGERF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZHTGERF>>(v1);
    }

    // decompiled from Move bytecode v6
}


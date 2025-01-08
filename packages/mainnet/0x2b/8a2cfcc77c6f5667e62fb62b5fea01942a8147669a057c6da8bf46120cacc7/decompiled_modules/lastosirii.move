module 0x2b8a2cfcc77c6f5667e62fb62b5fea01942a8147669a057c6da8bf46120cacc7::lastosirii {
    struct LASTOSIRII has drop {
        dummy_field: bool,
    }

    fun init(arg0: LASTOSIRII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASTOSIRII>(arg0, 9, b"LASTOSIRII", b"LASTOSIRI", b"SD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LASTOSIRII>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASTOSIRII>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LASTOSIRII>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xb3f3df828abd238491d45367804b6894093fbc35886c9669030da4d6316c45cd::last {
    struct LAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAST>(arg0, 9, b"last", b"Last", b"just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAST>>(v1);
    }

    // decompiled from Move bytecode v6
}


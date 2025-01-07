module 0x143babd701eb200bb9d2cdadf2ed102ad378d2234fb21d8b55f334668e56e06e::suie {
    struct SUIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIE>(arg0, 9, b"SUIE", b"SUIE", b"SUIES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIE>>(v1);
    }

    // decompiled from Move bytecode v6
}


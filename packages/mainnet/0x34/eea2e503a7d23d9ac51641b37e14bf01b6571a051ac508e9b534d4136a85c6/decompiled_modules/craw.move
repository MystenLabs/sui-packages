module 0x34eea2e503a7d23d9ac51641b37e14bf01b6571a051ac508e9b534d4136a85c6::craw {
    struct CRAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAW>(arg0, 6, b"CRAW", b"CRAWFISH", b"Time to boil!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t9_GCJ_4r_U_400x400_8019a90a6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAW>>(v1);
    }

    // decompiled from Move bytecode v6
}


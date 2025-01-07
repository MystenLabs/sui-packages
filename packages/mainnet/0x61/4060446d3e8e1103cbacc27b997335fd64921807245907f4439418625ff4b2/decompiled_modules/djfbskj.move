module 0x614060446d3e8e1103cbacc27b997335fd64921807245907f4439418625ff4b2::djfbskj {
    struct DJFBSKJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJFBSKJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJFBSKJ>(arg0, 6, b"DJFBSKJ", b"ss", b"s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fighting_47_8dba8e5fa3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJFBSKJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJFBSKJ>>(v1);
    }

    // decompiled from Move bytecode v6
}


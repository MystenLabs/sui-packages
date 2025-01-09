module 0x407aab094bafd104c9e69d2ad1fb858b4f9b07bc4aa17163617df338076d5d95::mobb {
    struct MOBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBB>(arg0, 6, b"MOBB", b"SUIMOBB", b"hi i'm MOBB, sometimes cute sometimes chaotic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000137323_3363cfdd17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBB>>(v1);
    }

    // decompiled from Move bytecode v6
}


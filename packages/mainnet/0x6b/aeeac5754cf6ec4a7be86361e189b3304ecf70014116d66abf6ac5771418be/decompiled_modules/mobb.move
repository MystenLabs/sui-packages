module 0x6baeeac5754cf6ec4a7be86361e189b3304ecf70014116d66abf6ac5771418be::mobb {
    struct MOBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBB>(arg0, 6, b"MOBB", b"suimobb", b"hi i'm MOBB, sometimes cute sometimes chaotic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000137323_d063d5acfb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBB>>(v1);
    }

    // decompiled from Move bytecode v6
}


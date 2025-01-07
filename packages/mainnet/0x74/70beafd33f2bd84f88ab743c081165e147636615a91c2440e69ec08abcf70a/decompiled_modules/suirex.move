module 0x7470beafd33f2bd84f88ab743c081165e147636615a91c2440e69ec08abcf70a::suirex {
    struct SUIREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREX>(arg0, 6, b"SUIREX", b"SuiRex", b"su-rks, Something big and blue Grrrrrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_05_46_20_a8d2306913.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREX>>(v1);
    }

    // decompiled from Move bytecode v6
}


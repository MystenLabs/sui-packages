module 0xacdb56604b7091ea899615d0d7d2f17b55f042c006ee1f236dbd845fbb454430::tuk {
    struct TUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUK>(arg0, 6, b"TUK", b"TUKTUK", b"NO humor for FOMO anymore.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic4godidufwfl6wliijxcjhjygxqmatoxo4ycy2inxrg5mxs7aw4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TUK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


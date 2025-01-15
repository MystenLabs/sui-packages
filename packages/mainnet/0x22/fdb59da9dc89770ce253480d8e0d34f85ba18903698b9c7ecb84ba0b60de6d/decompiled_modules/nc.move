module 0x22fdb59da9dc89770ce253480d8e0d34f85ba18903698b9c7ecb84ba0b60de6d::nc {
    struct NC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NC>(arg0, 6, b"NC", b"NEW CHAPTER", x"4e657720796561722e204e6577206d652e204e657720636861707465722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250115_172902_808_cc931358ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NC>>(v1);
    }

    // decompiled from Move bytecode v6
}


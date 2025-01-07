module 0xb4fc729c1fd145dd424f40d92e732e0a4231e1704ee73450fd559a40b19ebadb::yoi {
    struct YOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOI>(arg0, 6, b"Yoi", b"Yoi chihuahua wink", b"chihuahua wink", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/com_apple_Pasteboard_H6yy_SA_6c6dffe85a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOI>>(v1);
    }

    // decompiled from Move bytecode v6
}


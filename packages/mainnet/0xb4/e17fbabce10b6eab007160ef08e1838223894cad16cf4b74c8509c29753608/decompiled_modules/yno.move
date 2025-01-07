module 0xb4e17fbabce10b6eab007160ef08e1838223894cad16cf4b74c8509c29753608::yno {
    struct YNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YNO>(arg0, 6, b"YNO", b"Y U NO", b"Y U NO LIKE MY MEMES!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000143492_7e3b5a9ce3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YNO>>(v1);
    }

    // decompiled from Move bytecode v6
}


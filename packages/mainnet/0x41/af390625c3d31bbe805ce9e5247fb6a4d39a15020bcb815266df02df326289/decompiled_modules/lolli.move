module 0x41af390625c3d31bbe805ce9e5247fb6a4d39a15020bcb815266df02df326289::lolli {
    struct LOLLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLLI>(arg0, 6, b"LOLLI", b"LOLLIPOP", b"LOLLIPOPOPOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfplmxmsq6upbkjkr6jmzhmsgdfknjhzffwuogorskx34qmokr4m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOLLI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


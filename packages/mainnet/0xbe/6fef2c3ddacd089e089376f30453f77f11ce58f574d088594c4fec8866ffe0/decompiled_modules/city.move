module 0xbe6fef2c3ddacd089e089376f30453f77f11ce58f574d088594c4fec8866ffe0::city {
    struct CITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CITY>(arg0, 6, b"CITY", b"SUICITY", b"There are our city for every sui lovers,we are free to do anything we want to do ! never dump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zylsx_a11be44cf7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CITY>>(v1);
    }

    // decompiled from Move bytecode v6
}


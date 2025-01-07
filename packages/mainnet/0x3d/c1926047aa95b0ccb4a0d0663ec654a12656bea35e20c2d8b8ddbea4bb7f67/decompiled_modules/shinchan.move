module 0x3dc1926047aa95b0ccb4a0d0663ec654a12656bea35e20c2d8b8ddbea4bb7f67::shinchan {
    struct SHINCHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHINCHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINCHAN>(arg0, 6, b"SHINCHAN", b"SUINOSUKE", b"SuiNosukebecause who needs adult supervision when you're mooning Sui with a grin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3828_37f1dc4838.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINCHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHINCHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


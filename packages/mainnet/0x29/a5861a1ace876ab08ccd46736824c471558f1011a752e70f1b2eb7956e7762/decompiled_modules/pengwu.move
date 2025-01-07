module 0x29a5861a1ace876ab08ccd46736824c471558f1011a752e70f1b2eb7956e7762::pengwu {
    struct PENGWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGWU>(arg0, 6, b"PENGWU", b"Sui Pengwu", b"Spreading fun and excellence, penguin style", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013995_6cffadf562.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGWU>>(v1);
    }

    // decompiled from Move bytecode v6
}


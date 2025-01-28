module 0x80f296032ee3030d5c61b39f9a85fef2dd8956a629bf3814c5d4153c3cc3757e::tokyo {
    struct TOKYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKYO>(arg0, 6, b"TOKYO", b"TokyoVerseV1", b"Welcome to our new world, a place where innovation meets imagination!  We are proud to introduce TokyoVerse V1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tokyo_1c4ee76da8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKYO>>(v1);
    }

    // decompiled from Move bytecode v6
}


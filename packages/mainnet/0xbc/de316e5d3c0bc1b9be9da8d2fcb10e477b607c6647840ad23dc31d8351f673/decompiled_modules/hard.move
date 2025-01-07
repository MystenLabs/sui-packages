module 0xbcde316e5d3c0bc1b9be9da8d2fcb10e477b607c6647840ad23dc31d8351f673::hard {
    struct HARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARD>(arg0, 6, b"HARD", b"Suigra", b"The pill that gives hard candles", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_11_23_34_30_d1932cdbec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARD>>(v1);
    }

    // decompiled from Move bytecode v6
}


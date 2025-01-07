module 0xf77430d720bfee97dd9e9942cc417c18d68e67416a8987397ed5677a7aa86279::emush {
    struct EMUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMUSH>(arg0, 6, b"EMUSH", b"Elon mush", b"This Gon Take Me Straight To Space Like Im Elon Mush ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048524_8644dcf544.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}


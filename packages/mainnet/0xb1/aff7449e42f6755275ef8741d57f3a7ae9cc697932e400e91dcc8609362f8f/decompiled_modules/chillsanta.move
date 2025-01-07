module 0xb1aff7449e42f6755275ef8741d57f3a7ae9cc697932e400e91dcc8609362f8f::chillsanta {
    struct CHILLSANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSANTA>(arg0, 6, b"CHILLSANTA", b"CHILLGUYWIFSANTA", b"Just Chill Guy with a Santa hat. Spreading Christmas cheer all the way to send this coin to another galaxy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coin_e49745cb08.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLSANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}


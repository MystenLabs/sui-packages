module 0x524309e37426ea9da222533cbbd3f3684f52b1a8735929a0aff4c68e75ecb123::tito {
    struct TITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITO>(arg0, 6, b"TITO", b"The dog of Tito", b"This Is The One or $TITO represents a new era of dog coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050526_827694b0c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITO>>(v1);
    }

    // decompiled from Move bytecode v6
}


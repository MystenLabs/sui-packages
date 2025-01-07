module 0x20ee5a43441ae806f51e4afc908126b7dd5fa60988297665aee45494ca8f1808::poken {
    struct POKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEN>(arg0, 6, b"POKEN", b"POKEN SUI", b"POKEN MEME LOOK LIKE PONKE BUY IT AND DYOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eqc8xkuewb6bzbze9evaasokucyya_cuqalge15jwineqla6_918e1d81bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


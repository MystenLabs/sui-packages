module 0x9a9cee73d40271615a29df308739a50cad9b3f0eecb05fa95a9248ffd68f6886::plup {
    struct PLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUP>(arg0, 6, b"PLUP", b"Plup Sui", b"Sui chain meme Project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029186_8d5a67ea72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}


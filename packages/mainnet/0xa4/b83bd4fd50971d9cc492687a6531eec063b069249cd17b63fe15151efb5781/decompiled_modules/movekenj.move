module 0xa4b83bd4fd50971d9cc492687a6531eec063b069249cd17b63fe15151efb5781::movekenj {
    struct MOVEKENJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEKENJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEKENJ>(arg0, 6, b"Movekenj", b"movekenj", x"68747470733a2f2f6d6f766570756d702e636f6d2f0a696620737569206c6f766520796f756b65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6942_066cfb5f35.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEKENJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEKENJ>>(v1);
    }

    // decompiled from Move bytecode v6
}


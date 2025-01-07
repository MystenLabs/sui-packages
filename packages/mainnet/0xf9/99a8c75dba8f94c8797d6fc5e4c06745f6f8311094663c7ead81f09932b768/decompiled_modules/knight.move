module 0xf999a8c75dba8f94c8797d6fc5e4c06745f6f8311094663c7ead81f09932b768::knight {
    struct KNIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNIGHT>(arg0, 6, b"KNIGHT", b"Fallen knight sui", b"fallen knight a warrior who is given an honorary title by the head of a monarchy (or the Pope) or his representative for his services to the state, kingdom, or Church in the military field. $KNIGHT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul43_20241223154331_1e223365f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}


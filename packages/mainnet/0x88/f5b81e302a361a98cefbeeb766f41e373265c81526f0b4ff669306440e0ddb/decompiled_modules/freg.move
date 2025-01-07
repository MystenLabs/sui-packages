module 0x88f5b81e302a361a98cefbeeb766f41e373265c81526f0b4ff669306440e0ddb::freg {
    struct FREG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREG>(arg0, 6, b"Freg", b"Mr.Freg", b"Old meney mr.freg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fregggg_a6700584c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREG>>(v1);
    }

    // decompiled from Move bytecode v6
}


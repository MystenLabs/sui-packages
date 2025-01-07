module 0xa3f500205a8aa01f73d8ca14a38662c80f5162de8a48c70a7796ce680f672751::squts {
    struct SQUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUTS>(arg0, 6, b"SQUTS", b"squts the Squirrel", b"America was saved by a squirrel and a meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000113334_c611c6b28a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUTS>>(v1);
    }

    // decompiled from Move bytecode v6
}


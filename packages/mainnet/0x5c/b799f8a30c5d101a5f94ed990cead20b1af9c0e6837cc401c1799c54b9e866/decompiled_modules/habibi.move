module 0x5cb799f8a30c5d101a5f94ed990cead20b1af9c0e6837cc401c1799c54b9e866::habibi {
    struct HABIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HABIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HABIBI>(arg0, 6, b"HABIBI", b"HABIBICAT", b"In the land of $HABIBI, where luxury meets loyalty, only the finest prosper.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HABIBI_75b845f9da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HABIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HABIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}


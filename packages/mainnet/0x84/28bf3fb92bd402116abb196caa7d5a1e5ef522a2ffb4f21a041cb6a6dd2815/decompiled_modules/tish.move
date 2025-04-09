module 0x8428bf3fb92bd402116abb196caa7d5a1e5ef522a2ffb4f21a041cb6a6dd2815::tish {
    struct TISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TISH>(arg0, 6, b"Tish", b"Tariff fish", b"I speak as an important member of the ocean and everything is on the table, the decision to impose tariffs on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054151_71565bb841.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TISH>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xc1448ac328d2a23b27f72b8ce6fa91b40d08944411e45ef3a15dc0fc15c6e302::mssui {
    struct MSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSSUI>(arg0, 6, b"MSSUI", b"MissSui", b"Just one of Miss Suis ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2270_290dde1f2b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


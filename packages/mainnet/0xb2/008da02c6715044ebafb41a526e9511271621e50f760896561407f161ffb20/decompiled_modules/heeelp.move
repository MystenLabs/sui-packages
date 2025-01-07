module 0xb2008da02c6715044ebafb41a526e9511271621e50f760896561407f161ffb20::heeelp {
    struct HEEELP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEEELP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEEELP>(arg0, 6, b"HEEELP", b"HELP", b"help meeeeeeeeeeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_cats_31ebe2a17d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEEELP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEEELP>>(v1);
    }

    // decompiled from Move bytecode v6
}


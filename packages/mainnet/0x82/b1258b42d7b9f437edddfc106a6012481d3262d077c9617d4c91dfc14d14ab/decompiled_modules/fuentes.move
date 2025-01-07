module 0x82b1258b42d7b9f437edddfc106a6012481d3262d077c9617d4c91dfc14d14ab::fuentes {
    struct FUENTES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUENTES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUENTES>(arg0, 6, b"FUENTES", b"NICK", b"FUENTES ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nick_1d2883ff24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUENTES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUENTES>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xa0f7d3a24144ede96c2411ea24e4c9ee95e15a027b91e349fefdf6533f16ee20::mpepe {
    struct MPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPEPE>(arg0, 6, b"MPEPE", b"MOOPEPE", b"Just a lil viral hippo on pepe world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BANK_7699b34b2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}


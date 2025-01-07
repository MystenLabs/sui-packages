module 0x33733c418b50f70e93b105f8192d8ec59079530a262e8981edfd12951131acef::mstr {
    struct MSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTR>(arg0, 6, b"MSTR", b"Mstr", b"MSTR: 2100 Crypto enthusiasts, led by a bold CEO, stacked their sats, and crowned it the king of crypto stocks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6704be250b29abf351d01251_1728364069_c4b7624a77.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}


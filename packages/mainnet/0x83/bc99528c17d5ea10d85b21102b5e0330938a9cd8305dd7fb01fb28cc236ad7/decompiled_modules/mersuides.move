module 0x83bc99528c17d5ea10d85b21102b5e0330938a9cd8305dd7fb01fb28cc236ad7::mersuides {
    struct MERSUIDES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERSUIDES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERSUIDES>(arg0, 6, b"MERSUIDES", b"Mersuides Buns", b"Vroom vroom vroom SUI!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031349_419e1c3a16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERSUIDES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERSUIDES>>(v1);
    }

    // decompiled from Move bytecode v6
}


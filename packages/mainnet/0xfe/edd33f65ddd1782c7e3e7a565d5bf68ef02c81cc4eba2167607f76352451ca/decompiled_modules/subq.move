module 0xfeedd33f65ddd1782c7e3e7a565d5bf68ef02c81cc4eba2167607f76352451ca::subq {
    struct SUBQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBQ>(arg0, 6, b"SUBQ", b"Subquaria", b"Community Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ariel_2_7cccd8f7d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBQ>>(v1);
    }

    // decompiled from Move bytecode v6
}


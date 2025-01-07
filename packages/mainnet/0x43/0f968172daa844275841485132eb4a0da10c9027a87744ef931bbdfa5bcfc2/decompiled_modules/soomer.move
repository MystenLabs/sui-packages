module 0x430f968172daa844275841485132eb4a0da10c9027a87744ef931bbdfa5bcfc2::soomer {
    struct SOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOMER>(arg0, 6, b"SOOMER", b"SOOMER ON SUI", b"SOOMER represents a new dawn for SUI enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SITELOGO_2_300x300_7780cd12d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}


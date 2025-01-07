module 0x14c7b3a7e257d20f5b0ec08b1d0e96ff8337fee4802e58ad4ae553aad67652d3::pepasurf {
    struct PEPASURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPASURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPASURF>(arg0, 6, b"PEPASURF", b"PepaSurf", b"https://t.me/SuiSniperBot?start=NDP2LR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepea_ce2123b902.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPASURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPASURF>>(v1);
    }

    // decompiled from Move bytecode v6
}


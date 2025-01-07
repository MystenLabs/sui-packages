module 0xf28413dbf2803973858f1695d7a731d5d08f05aad875143335096c99efed33bb::pepasurf {
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


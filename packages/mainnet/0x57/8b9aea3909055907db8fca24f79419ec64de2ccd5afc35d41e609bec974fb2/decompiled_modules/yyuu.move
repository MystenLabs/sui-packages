module 0x578b9aea3909055907db8fca24f79419ec64de2ccd5afc35d41e609bec974fb2::yyuu {
    struct YYUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YYUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YYUU>(arg0, 6, b"YYUU", b"YUYYY", b"YYYEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1792133304728.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YYUU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YYUU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


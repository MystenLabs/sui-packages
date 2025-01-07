module 0x72dbfae67c433225ee168523f2d14bf01b0d1ddae0d08177f0b8cadcb487533a::tcat {
    struct TCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCAT>(arg0, 6, b"TCAT", b"TURBO CAT", b"Welcome to Turbo CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959312014.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


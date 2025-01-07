module 0x1cbc9aaae9ef4e6d35e2ec5096aae29d02a863d4575de5c703c044906a336159::gymcat {
    struct GYMCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYMCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYMCAT>(arg0, 6, b"GYMCAT", b"CAT IN GYM", b" GYMCAT a suimeme coin in crypto to have fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CAT_IN_GYM_GYMCAT_449e2fa8cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYMCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GYMCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xcf536c4befbd7aefa47b1d4928367ef2ad708a7fd2360fd726dff006f1fc47f9::suicats {
    struct SUICATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATS>(arg0, 6, b"SUICATS", b"SUICATSCOIN", b"Running wild on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_60e630cd0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATS>>(v1);
    }

    // decompiled from Move bytecode v6
}


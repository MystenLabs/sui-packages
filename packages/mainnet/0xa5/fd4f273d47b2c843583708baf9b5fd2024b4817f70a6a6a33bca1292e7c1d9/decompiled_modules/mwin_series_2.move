module 0xa5fd4f273d47b2c843583708baf9b5fd2024b4817f70a6a6a33bca1292e7c1d9::mwin_series_2 {
    struct MWIN_SERIES_2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWIN_SERIES_2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWIN_SERIES_2>(arg0, 9, b"mWIN", b"mWIN Series 2", b"mWIN Series 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://winx.io/mWIN.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWIN_SERIES_2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWIN_SERIES_2>>(v1);
    }

    // decompiled from Move bytecode v6
}


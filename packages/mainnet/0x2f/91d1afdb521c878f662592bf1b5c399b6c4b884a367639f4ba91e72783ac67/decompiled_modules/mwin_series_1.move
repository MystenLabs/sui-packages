module 0x2f91d1afdb521c878f662592bf1b5c399b6c4b884a367639f4ba91e72783ac67::mwin_series_1 {
    struct MWIN_SERIES_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWIN_SERIES_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWIN_SERIES_1>(arg0, 9, b"mWIN", b"mWIN Series 1", b"mWIN Series 1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://winx.io/mWIN.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWIN_SERIES_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWIN_SERIES_1>>(v1);
    }

    // decompiled from Move bytecode v6
}


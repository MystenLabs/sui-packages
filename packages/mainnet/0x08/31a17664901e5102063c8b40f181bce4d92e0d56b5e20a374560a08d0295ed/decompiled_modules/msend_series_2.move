module 0x831a17664901e5102063c8b40f181bce4d92e0d56b5e20a374560a08d0295ed::msend_series_2 {
    struct MSEND_SERIES_2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSEND_SERIES_2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSEND_SERIES_2>(arg0, 6, b"mSEND", b"mSEND Series 2", b"mSEND(2024/12/12-2025/06/12) SUI 0.5->0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/SEND/mSEND.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSEND_SERIES_2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSEND_SERIES_2>>(v1);
    }

    // decompiled from Move bytecode v6
}


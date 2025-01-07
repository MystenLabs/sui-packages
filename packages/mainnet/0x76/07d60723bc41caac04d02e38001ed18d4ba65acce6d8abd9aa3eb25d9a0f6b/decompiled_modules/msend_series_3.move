module 0x7607d60723bc41caac04d02e38001ed18d4ba65acce6d8abd9aa3eb25d9a0f6b::msend_series_3 {
    struct MSEND_SERIES_3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSEND_SERIES_3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSEND_SERIES_3>(arg0, 6, b"mSEND", b"mSEND Series 3", b"mSEND(2024/12/12-2025/12/12) SUI 0.37->0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/SEND/mSEND.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSEND_SERIES_3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSEND_SERIES_3>>(v1);
    }

    // decompiled from Move bytecode v6
}


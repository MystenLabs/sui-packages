module 0xda097d57ae887fbd002fb5847dd0ab47ae7e1b183fd36832a51182c52257e1bc::msend_series_1 {
    struct MSEND_SERIES_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSEND_SERIES_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSEND_SERIES_1>(arg0, 6, b"mSEND", b"mSEND Series 1", b"mSEND(2024/12/12-2025/03/12) SUI 0.25->0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/SEND/mSEND.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSEND_SERIES_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSEND_SERIES_1>>(v1);
    }

    // decompiled from Move bytecode v6
}


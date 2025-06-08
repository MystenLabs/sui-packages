module 0x44805fa08d1b62e96df8297cf10953a8374a447e3bd6aed34228ee3b6ffd4ec3::b_msend_series_1 {
    struct B_MSEND_SERIES_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MSEND_SERIES_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MSEND_SERIES_1>(arg0, 9, b"bmSEND", b"bToken mSEND", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MSEND_SERIES_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MSEND_SERIES_1>>(v1);
    }

    // decompiled from Move bytecode v6
}


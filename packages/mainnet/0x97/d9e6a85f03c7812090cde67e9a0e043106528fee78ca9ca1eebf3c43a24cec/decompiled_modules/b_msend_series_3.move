module 0x97d9e6a85f03c7812090cde67e9a0e043106528fee78ca9ca1eebf3c43a24cec::b_msend_series_3 {
    struct B_MSEND_SERIES_3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MSEND_SERIES_3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MSEND_SERIES_3>(arg0, 9, b"bmSEND", b"bToken mSEND", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MSEND_SERIES_3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MSEND_SERIES_3>>(v1);
    }

    // decompiled from Move bytecode v6
}


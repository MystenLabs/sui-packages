module 0xa7a3902e56d4c2bc320ba41bdf46a04d8723590724497b21360dcb728df31074::b_mattn_series_3 {
    struct B_MATTN_SERIES_3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MATTN_SERIES_3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MATTN_SERIES_3>(arg0, 9, b"bmATTN", b"bToken mATTN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MATTN_SERIES_3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MATTN_SERIES_3>>(v1);
    }

    // decompiled from Move bytecode v6
}


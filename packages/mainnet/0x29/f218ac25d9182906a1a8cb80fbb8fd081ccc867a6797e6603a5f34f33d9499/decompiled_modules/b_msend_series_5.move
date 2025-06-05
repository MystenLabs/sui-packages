module 0x29f218ac25d9182906a1a8cb80fbb8fd081ccc867a6797e6603a5f34f33d9499::b_msend_series_5 {
    struct B_MSEND_SERIES_5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MSEND_SERIES_5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MSEND_SERIES_5>(arg0, 9, b"bmSEND", b"bToken mSEND", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MSEND_SERIES_5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MSEND_SERIES_5>>(v1);
    }

    // decompiled from Move bytecode v6
}


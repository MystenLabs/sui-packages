module 0xe1a2d99417ccc820634826557f4774b3b969621c4ccdc55e757c254e6038082::b_msend_series_4 {
    struct B_MSEND_SERIES_4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MSEND_SERIES_4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MSEND_SERIES_4>(arg0, 9, b"bmSEND", b"bToken mSEND", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MSEND_SERIES_4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MSEND_SERIES_4>>(v1);
    }

    // decompiled from Move bytecode v6
}


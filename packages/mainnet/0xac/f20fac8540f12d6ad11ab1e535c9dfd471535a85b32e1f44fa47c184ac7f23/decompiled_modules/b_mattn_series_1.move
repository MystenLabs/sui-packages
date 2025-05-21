module 0xacf20fac8540f12d6ad11ab1e535c9dfd471535a85b32e1f44fa47c184ac7f23::b_mattn_series_1 {
    struct B_MATTN_SERIES_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MATTN_SERIES_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MATTN_SERIES_1>(arg0, 9, b"bmATTN", b"bToken mATTN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MATTN_SERIES_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MATTN_SERIES_1>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xcb6c3f07c7d956d72305338db92254060f6a2c8f3b3ae849ecd9f77dde83e41b::b_octo {
    struct B_OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OCTO>(arg0, 9, b"bOCTO", b"bToken OCTO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}


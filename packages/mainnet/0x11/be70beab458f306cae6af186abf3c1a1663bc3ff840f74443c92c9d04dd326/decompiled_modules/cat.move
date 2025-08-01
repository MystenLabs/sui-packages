module 0x11be70beab458f306cae6af186abf3c1a1663bc3ff840f74443c92c9d04dd326::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 9, b"CAT", b"Cat", b"11111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"222.jpg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CAT>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


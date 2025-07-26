module 0x1d4597b8f082ba35dfd0f82eb610f1596b2d8e9dc043d61d1b6b475f75ce46a8::b_rose {
    struct B_ROSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ROSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ROSE>(arg0, 9, b"bROSE", b"bToken ROSE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ROSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ROSE>>(v1);
    }

    // decompiled from Move bytecode v6
}


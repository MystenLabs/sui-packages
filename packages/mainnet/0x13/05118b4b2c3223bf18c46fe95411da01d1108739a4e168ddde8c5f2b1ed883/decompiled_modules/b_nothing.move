module 0x1305118b4b2c3223bf18c46fe95411da01d1108739a4e168ddde8c5f2b1ed883::b_nothing {
    struct B_NOTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NOTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NOTHING>(arg0, 9, b"bNOTHING", b"bToken NOTHING", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NOTHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NOTHING>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xb3795b0f21c1b68596ed97e7379d18fcfe6501ce67924e6ed4a7070b2b036fb3::b_rjrk {
    struct B_RJRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_RJRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_RJRK>(arg0, 9, b"bRJRK", b"bToken RJRK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_RJRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_RJRK>>(v1);
    }

    // decompiled from Move bytecode v6
}


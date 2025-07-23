module 0x4892248dfbcd2d00f149c18075c2e62d6838ba57f81e26865d32fdbd0ff2b87e::b_sendcto {
    struct B_SENDCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SENDCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SENDCTO>(arg0, 9, b"bSENDCTO", b"bToken SENDCTO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SENDCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SENDCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}


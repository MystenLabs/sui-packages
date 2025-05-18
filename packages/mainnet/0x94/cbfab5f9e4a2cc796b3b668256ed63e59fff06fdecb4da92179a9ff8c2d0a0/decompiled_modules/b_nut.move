module 0x94cbfab5f9e4a2cc796b3b668256ed63e59fff06fdecb4da92179a9ff8c2d0a0::b_nut {
    struct B_NUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NUT>(arg0, 9, b"bNUT", b"bToken NUT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NUT>>(v1);
    }

    // decompiled from Move bytecode v6
}


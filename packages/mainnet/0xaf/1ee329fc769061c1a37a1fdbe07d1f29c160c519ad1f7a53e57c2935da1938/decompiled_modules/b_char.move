module 0xaf1ee329fc769061c1a37a1fdbe07d1f29c160c519ad1f7a53e57c2935da1938::b_char {
    struct B_CHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CHAR>(arg0, 9, b"bCHAR", b"bToken CHAR", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CHAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CHAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


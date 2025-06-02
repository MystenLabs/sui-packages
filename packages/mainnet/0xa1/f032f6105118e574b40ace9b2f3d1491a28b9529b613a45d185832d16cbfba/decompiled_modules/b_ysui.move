module 0xa1f032f6105118e574b40ace9b2f3d1491a28b9529b613a45d185832d16cbfba::b_ysui {
    struct B_YSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_YSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_YSUI>(arg0, 9, b"bySUI", b"bToken ySUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_YSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_YSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x1016b400d190c9461c27a02e687ec0d7a661ae0ee612ae1580ee46b526be7afa::b_korin {
    struct B_KORIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KORIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KORIN>(arg0, 9, b"bKORIN", b"bToken KORIN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KORIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KORIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


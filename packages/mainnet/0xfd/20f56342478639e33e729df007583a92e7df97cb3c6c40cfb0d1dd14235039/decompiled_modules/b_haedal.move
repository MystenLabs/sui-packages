module 0xfd20f56342478639e33e729df007583a92e7df97cb3c6c40cfb0d1dd14235039::b_haedal {
    struct B_HAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HAEDAL>(arg0, 9, b"bHAEDAL", b"bToken HAEDAL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HAEDAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HAEDAL>>(v1);
    }

    // decompiled from Move bytecode v6
}


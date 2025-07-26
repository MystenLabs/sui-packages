module 0xf4f78d1b4dd714a7d69b5c2409412787c5db7a923912d7e5f2c68375989689cd::b_dege {
    struct B_DEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DEGE>(arg0, 9, b"bDEGE", b"bToken DEGE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DEGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DEGE>>(v1);
    }

    // decompiled from Move bytecode v6
}


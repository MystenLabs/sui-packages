module 0x8d570e8ab8b3c9e3b8bc32180254685b67942afbd44723c9dd7c6d38826e2d52::bear {
    struct BEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAR>(arg0, 6, b"BEAR", b"SuiBEAR", b"By the community, For the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bear_6b435595b5.jpg_large")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


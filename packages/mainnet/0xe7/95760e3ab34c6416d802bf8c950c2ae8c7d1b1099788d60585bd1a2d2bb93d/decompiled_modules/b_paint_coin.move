module 0xe795760e3ab34c6416d802bf8c950c2ae8c7d1b1099788d60585bd1a2d2bb93d::b_paint_coin {
    struct B_PAINT_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAINT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAINT_COIN>(arg0, 9, b"bPAINT", b"bToken PAINT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAINT_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAINT_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


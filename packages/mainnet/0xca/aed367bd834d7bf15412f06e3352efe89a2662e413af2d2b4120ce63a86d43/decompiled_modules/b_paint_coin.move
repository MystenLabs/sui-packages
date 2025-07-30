module 0xcaaed367bd834d7bf15412f06e3352efe89a2662e413af2d2b4120ce63a86d43::b_paint_coin {
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


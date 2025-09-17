module 0x6b6edc87d79e54cad0461d4c58c2ef0da8907ac11e365c0552ce156ca3f488f7::b_moon {
    struct B_MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MOON>(arg0, 9, b"bMOON", b"bToken MOON", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}


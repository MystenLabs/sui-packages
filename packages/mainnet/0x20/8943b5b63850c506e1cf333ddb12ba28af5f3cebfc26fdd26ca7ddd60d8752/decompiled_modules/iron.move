module 0x208943b5b63850c506e1cf333ddb12ba28af5f3cebfc26fdd26ca7ddd60d8752::iron {
    struct IRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRON>(arg0, 6, b"IRON", b"SUIRONMAN", b"IRONMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ironman_f2102f9689.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRON>>(v1);
    }

    // decompiled from Move bytecode v6
}


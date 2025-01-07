module 0xde5537c523d3fa59c3bf2051015000d65b622048d2d89590e539ead1abac64e7::rugpug {
    struct RUGPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGPUG>(arg0, 6, b"RUGPUG", b"PUG IN A RUG", b"Rugpug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1058_26dc60731e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}


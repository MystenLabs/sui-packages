module 0x570f585a0f3751a008dadbf6a99d65b1a8c7a47eb6807f40cd4f0766fe07bed7::wisdom {
    struct WISDOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WISDOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WISDOM>(arg0, 6, b"WISDOM", b"Suiyuan", b"Ancient wisdom, modern gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_3190_65758516fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WISDOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WISDOM>>(v1);
    }

    // decompiled from Move bytecode v6
}


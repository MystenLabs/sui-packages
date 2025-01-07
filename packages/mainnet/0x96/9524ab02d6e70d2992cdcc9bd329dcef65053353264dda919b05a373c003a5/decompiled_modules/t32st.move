module 0x969524ab02d6e70d2992cdcc9bd329dcef65053353264dda919b05a373c003a5::t32st {
    struct T32ST has drop {
        dummy_field: bool,
    }

    fun init(arg0: T32ST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T32ST>(arg0, 6, b"T32sT", b"T3ST", b"T3sT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Black_Myth_Wukong_Game_Science_b7dc305618.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T32ST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T32ST>>(v1);
    }

    // decompiled from Move bytecode v6
}


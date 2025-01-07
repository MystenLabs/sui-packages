module 0x2fd127f3391f2837f3b1a5f94c3da3c3a69eb954b7a6693a5dfdc12a368b1470::here {
    struct HERE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERE>(arg0, 6, b"HERE", b"Here", b"... Here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_23_17_52_51_2cadfe18e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HERE>>(v1);
    }

    // decompiled from Move bytecode v6
}


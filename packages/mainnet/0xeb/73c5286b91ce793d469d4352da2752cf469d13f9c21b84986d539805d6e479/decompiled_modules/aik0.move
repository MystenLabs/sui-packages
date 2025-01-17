module 0xeb73c5286b91ce793d469d4352da2752cf469d13f9c21b84986d539805d6e479::aik0 {
    struct AIK0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIK0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIK0>(arg0, 6, b"AIK0", b"AiK0", b"An agent inspired by AI16Z.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1420_738a4e2d55.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIK0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIK0>>(v1);
    }

    // decompiled from Move bytecode v6
}


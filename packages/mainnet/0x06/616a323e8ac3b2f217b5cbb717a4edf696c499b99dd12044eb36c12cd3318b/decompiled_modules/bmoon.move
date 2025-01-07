module 0x6616a323e8ac3b2f217b5cbb717a4edf696c499b99dd12044eb36c12cd3318b::bmoon {
    struct BMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMOON>(arg0, 6, b"BMOON", b"Bluemoon", b"A blue moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9739_c74671ee62.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xc09c69257c21eb6fd02682d3c4ba45a0be4ccaa50bad09a45b7310d64834344a::smo {
    struct SMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMO>(arg0, 6, b"SMO", b"SmilingOtter", b"Smiling otter are way better than smiling dolphin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2947_73de83c5eb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMO>>(v1);
    }

    // decompiled from Move bytecode v6
}


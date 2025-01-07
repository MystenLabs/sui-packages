module 0xdb1a7ff0c3ee19b10132262d0a3fa1868365dc9b71c9b7a72923b17067b8f425::tvh {
    struct TVH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TVH>(arg0, 6, b"TVH", b"Trump vs. Harris", b"Trump vs. Harris: How rhetorical framing could decide the 2024 election.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1778_860d50b7c2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TVH>>(v1);
    }

    // decompiled from Move bytecode v6
}


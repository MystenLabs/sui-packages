module 0x820758289804157ec8559ab5942822d68dd8c2e68476e10fc93ba672f8865cf9::cilon {
    struct CILON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CILON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CILON>(arg0, 6, b"CILON", b"Cilon Turtle", b"Welcome to Cilon's Turtle Memes Community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026516_3ba8f257b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CILON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CILON>>(v1);
    }

    // decompiled from Move bytecode v6
}


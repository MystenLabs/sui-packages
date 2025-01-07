module 0x888e803bc6b9f48e5f94c2b2fb9546a27f5dfa0890048f3343020ed551063791::cheese {
    struct CHEESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEESE>(arg0, 6, b"CHEESE", b"Sui Cheese", b"CHEESE Isn't just a meme-it's a flex a lifestyle a revolution  Stack gold, crush limits, and own the streets . If you're not in , you're OUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012516_1bba1fb36b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEESE>>(v1);
    }

    // decompiled from Move bytecode v6
}


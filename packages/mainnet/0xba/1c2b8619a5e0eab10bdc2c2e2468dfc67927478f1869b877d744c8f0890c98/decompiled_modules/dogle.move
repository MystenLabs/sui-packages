module 0xba1c2b8619a5e0eab10bdc2c2e2468dfc67927478f1869b877d744c8f0890c98::dogle {
    struct DOGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGLE>(arg0, 6, b"DOGLE", b"Doge Google", b"$DOGLE is a dog themed google, The popularity of dogs is growing and cryptocurrency is  stranger to using dog images and symbols to create works and project developments", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039290_af47f3fe8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}


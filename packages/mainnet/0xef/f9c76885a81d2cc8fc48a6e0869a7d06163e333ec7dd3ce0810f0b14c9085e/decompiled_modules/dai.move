module 0xeff9c76885a81d2cc8fc48a6e0869a7d06163e333ec7dd3ce0810f0b14c9085e::dai {
    struct DAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAI>(arg0, 6, b"DAI", b"DystopiAI", b"In a dystopian AI future, meme coins are the only shield against total control. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dystopiai_coin_1_e662c0ce62.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAI>>(v1);
    }

    // decompiled from Move bytecode v6
}


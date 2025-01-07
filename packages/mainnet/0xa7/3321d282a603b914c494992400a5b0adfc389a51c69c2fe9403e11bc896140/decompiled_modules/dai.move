module 0xa73321d282a603b914c494992400a5b0adfc389a51c69c2fe9403e11bc896140::dai {
    struct DAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAI>(arg0, 6, b"DAI", b"DystopiAI", b"In a dystopian AI future, meme coins are the only shield against total control. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dystopiai_coin_1_26012e3bb7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAI>>(v1);
    }

    // decompiled from Move bytecode v6
}


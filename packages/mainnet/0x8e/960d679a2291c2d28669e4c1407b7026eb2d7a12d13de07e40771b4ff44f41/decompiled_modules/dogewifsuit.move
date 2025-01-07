module 0x8e960d679a2291c2d28669e4c1407b7026eb2d7a12d13de07e40771b4ff44f41::dogewifsuit {
    struct DOGEWIFSUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEWIFSUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEWIFSUIT>(arg0, 6, b"DOGEWIFSUIT", b"Doge Wif Suit", b"One beautiful day in the city of SuiChainVille, where everything revolves around cryptocurrency and technology, there was a dog named Doge. Unlike ordinary dogs, Doge always appeared in a dapper suit and a tie featuring the Sui logo in style....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_9_790ede88bc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEWIFSUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEWIFSUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}


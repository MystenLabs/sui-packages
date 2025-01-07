module 0xa84788e06f65bec02b44c2e4b03bfb09d311f04ae26918beb06920fdec289572::gru {
    struct GRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRU>(arg0, 6, b"Gru", b"ELONS MINIONS", b"ntroducing ELONS MINIONS (Gru Coin)  the next big contender in the world of meme tokens within the cryptocurrency space! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725121112984_af8298dcbe7f2a7e746cc4ba8eb58fb3_20d5aa3908.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRU>>(v1);
    }

    // decompiled from Move bytecode v6
}


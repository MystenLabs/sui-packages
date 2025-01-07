module 0x19084fa24748442b3ea1ececcc864610592d56709380be30303a1465c8ae13a6::pengsui {
    struct PENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSUI>(arg0, 6, b"PENGSUI", b"PENGUIN", b"In the frigid, untamed lands of Antarctica, where only the strongest survive, a legend is born. Meet Max, the unstoppable penguin who doesnt just waddlehe conquers! Born in the icy heart of Antarctica, But what makes this penguin extraordinary isn't just his survival. Its his ambition. Unlike the others who waddle through life, Maximus dreams of soaring beyond the icy seas, to conquer new realmsrealms where no penguin has dared to go before. And just like him, PenguinCoin is here to stand strong in the crypto world. $SUIPENG token is your entry into this face-melting SUI memecoin experience!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/penguins_1_nbg_b014e9c6e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


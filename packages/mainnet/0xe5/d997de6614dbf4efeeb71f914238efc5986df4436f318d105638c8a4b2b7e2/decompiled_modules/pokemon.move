module 0xe5d997de6614dbf4efeeb71f914238efc5986df4436f318d105638c8a4b2b7e2::pokemon {
    struct POKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<POKEMON>(arg0, 6, b"POKEMON", b"Pokemon Coin", b"Pokemon Coin is a fun and exciting cryptocurrency inspired by the popular Pokemon franchise. Catch 'em all and invest in the world of Pokemon with the Pokemon Coin! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/05xbo7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEMON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


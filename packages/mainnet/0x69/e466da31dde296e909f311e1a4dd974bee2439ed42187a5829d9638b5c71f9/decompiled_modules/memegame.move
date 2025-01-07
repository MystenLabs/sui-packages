module 0x69e466da31dde296e909f311e1a4dd974bee2439ed42187a5829d9638b5c71f9::memegame {
    struct MEMEGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEGAME>(arg0, 6, b"MEMEGAME", b"THE MEME GAME", b"The true meme games have arrived, with up to $100,000 in prizes. Join by purchasing our token, the game will start soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042024_658cede051.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEGAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEGAME>>(v1);
    }

    // decompiled from Move bytecode v6
}


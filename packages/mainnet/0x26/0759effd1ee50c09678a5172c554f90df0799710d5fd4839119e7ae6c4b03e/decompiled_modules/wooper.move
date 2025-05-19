module 0x260759effd1ee50c09678a5172c554f90df0799710d5fd4839119e7ae6c4b03e::wooper {
    struct WOOPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOPER>(arg0, 6, b"WOOPER", b"Suiper Wooper", b"SUIPER WOOPER, The Meme Token That Feels Like Suiper Monster. Wooper isnt just a meme token on SUI. its a movement. Powered by good vibes, community energy, and that adorable little creature we all love.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib3gwzui3cys7eiqfjv4d6pws4ywihtqfeog6f6mokekyirectinm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOOPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


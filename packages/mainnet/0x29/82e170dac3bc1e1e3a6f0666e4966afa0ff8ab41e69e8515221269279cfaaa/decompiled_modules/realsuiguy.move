module 0x2982e170dac3bc1e1e3a6f0666e4966afa0ff8ab41e69e8515221269279cfaaa::realsuiguy {
    struct REALSUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALSUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALSUIGUY>(arg0, 6, b"RealSuiGuy", b"TheRealSuiGuy", b"We are real and remember the truth always comes out. Welcome to the new God of Sui Memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif5dmzvifgpbwxykgrilidg7me4fjr6q764optvv4cqn2sclanuxe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALSUIGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REALSUIGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


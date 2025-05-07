module 0x3a737dc13385270d0dfe829a44d6fd128566029fc657d14cdb2b2f368ccc8ff1::realguy {
    struct REALGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALGUY>(arg0, 6, b"RealGuy", b"The Real Sui Guy", b"We are real and remember the truth always comes out. Welcome to the new God of Sui Memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig5fw2q4uv5wvvil4zriqtpaiyxzx4rkkjbhgd6bedoaxzxkmdbsq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REALGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


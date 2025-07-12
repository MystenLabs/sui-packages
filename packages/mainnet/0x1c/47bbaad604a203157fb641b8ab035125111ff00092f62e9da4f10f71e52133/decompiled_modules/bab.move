module 0x1c47bbaad604a203157fb641b8ab035125111ff00092f62e9da4f10f71e52133::bab {
    struct BAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAB>(arg0, 6, b"BAB", b"Bob And Billy", b"Bob and Billy is more than a meme, he's a movement. A symbol of strength, unity, and swamp born resilience. Built on the Sui blockchain, Bob & Billy leads a community driven push toward a fun, bold DeFi future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihjvmzcm5f3fl7zadddeyq3cjbg6kgt3tueavh6zwzrn5u2kxifnu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


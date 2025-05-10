module 0x96b3b24d25e61e9dc5e3dc5319c81b709c2fc5ee709b679daeaba531ed81ad66::charizar {
    struct CHARIZAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARIZAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARIZAR>(arg0, 6, b"CHARIZAR", b"CHARIZARD", b"Blazing onto the Sui blockchain, CHARIZARD is the ultimate meme token with zero fluff and all fire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiawt3qdortjq6nze6wq3m65hjdptjywz5zo3keg4cqprhujlmmzcy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARIZAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHARIZAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


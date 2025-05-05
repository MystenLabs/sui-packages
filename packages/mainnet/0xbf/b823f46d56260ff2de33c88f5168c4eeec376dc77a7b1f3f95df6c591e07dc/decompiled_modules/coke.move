module 0xbfb823f46d56260ff2de33c88f5168c4eeec376dc77a7b1f3f95df6c591e07dc::coke {
    struct COKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COKE>(arg0, 6, b"COKE", b"COKEMON", b"gotta sniff em all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiddt2tqwkqffsciypil334xlug2kgc7xjtfqhsidnu56ieceyxmhe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


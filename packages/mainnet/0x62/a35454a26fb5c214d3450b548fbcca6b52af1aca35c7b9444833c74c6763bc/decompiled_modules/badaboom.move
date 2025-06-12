module 0x62a35454a26fb5c214d3450b548fbcca6b52af1aca35c7b9444833c74c6763bc::badaboom {
    struct BADABOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADABOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADABOOM>(arg0, 6, b"BADABOOM", b"Banana Kaboom", b"Badaboom is the Minion-fueled memecoin bursting with chaotic fun and pure meme magic. Unfiltered minion energy ready to shake up the crypto scene. Join the banana party!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia4427lj4iycezklxoescsginylqwsfngxzoch5wbj3hcu5a52kay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADABOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BADABOOM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


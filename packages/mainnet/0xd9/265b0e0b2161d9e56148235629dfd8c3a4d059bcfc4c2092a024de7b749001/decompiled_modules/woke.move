module 0xd9265b0e0b2161d9e56148235629dfd8c3a4d059bcfc4c2092a024de7b749001::woke {
    struct WOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOKE>(arg0, 6, b"WOKE", b"Woke Cat", b"No utility, just purrs and pump. Cancel us? Too late, we already rugged the wokeverse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidxfkund3iewkuh2dunbkwq4dtzupzt4tdbqphh6qoaeevqi5awsy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


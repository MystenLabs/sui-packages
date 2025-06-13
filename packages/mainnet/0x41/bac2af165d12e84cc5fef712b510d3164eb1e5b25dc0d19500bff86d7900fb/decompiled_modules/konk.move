module 0x41bac2af165d12e84cc5fef712b510d3164eb1e5b25dc0d19500bff86d7900fb::konk {
    struct KONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONK>(arg0, 6, b"KONK", b"Konke", b"Konke is now live on the Sui network, from branch to branch, from purchase to purchase, Konke will prosper.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib3z7npqhtyqviogu5pujlxmrxbaju77rncyt2rx5p7mtzkhki2hi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KONK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


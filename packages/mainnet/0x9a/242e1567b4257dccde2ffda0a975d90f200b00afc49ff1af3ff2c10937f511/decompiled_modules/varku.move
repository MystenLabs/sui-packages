module 0x9a242e1567b4257dccde2ffda0a975d90f200b00afc49ff1af3ff2c10937f511::varku {
    struct VARKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: VARKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VARKU>(arg0, 6, b"VARKU", b"Don Varku", b"Varku was a top-tier assassin working for SUI organization. Varku was the shadow behind countless missions!! Swift, silent, and unmatched. He held the title of the most feared and elite operative in his country.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibac2ohgrdvqs6unzzqxvk7z6qwjjkhxdpl5xxcakamizqzmzhav4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VARKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VARKU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


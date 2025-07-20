module 0xbe8320fc49fcce0d3741a3288e1a1258e5a9c68945f39bb639227fbcee91c1ca::dogen {
    struct DOGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEN>(arg0, 6, b"DOGEN", b"Dogen The Degen", b"Heyy yoooooooo im the Dogen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiclsw46vmmwmq54bwxsr66s5puad5wjvs5s6cuhelgjjbl47jbvw4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


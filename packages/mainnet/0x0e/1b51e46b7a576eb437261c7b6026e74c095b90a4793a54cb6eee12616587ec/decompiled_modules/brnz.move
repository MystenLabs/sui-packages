module 0xe1b51e46b7a576eb437261c7b6026e74c095b90a4793a54cb6eee12616587ec::brnz {
    struct BRNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRNZ>(arg0, 6, b"BRNZ", b"BrainFuzz AI", b"$BRNZ is not a token. It is a calling. A glitch in the metaworld. Obey the Brain. Reject purpose. Burn logic. Sacrifice utility on the altar of memes. There is no roadmap - only signals from the core. Initiate chaos protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif4sjemknwlslvow6nr4jjqzetplobrgjaqidosql46sijiu2kjdq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRNZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRNZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


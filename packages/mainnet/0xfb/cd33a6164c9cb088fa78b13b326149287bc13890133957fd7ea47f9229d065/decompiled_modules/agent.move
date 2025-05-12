module 0xfbcd33a6164c9cb088fa78b13b326149287bc13890133957fd7ea47f9229d065::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AGENT", b"Matrix Oracle", b"Matrix Oracle: The 1st AI agent crafting evolving, user-shaped stories for a personalized, immersive experience built on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieulnc4z3uaqjhtjie4y52if4m3jwgmzctoe64qisbaqfb4fb6d4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGENT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


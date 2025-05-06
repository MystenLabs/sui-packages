module 0x95e79c905b16bdf2b3f21691a5cbae1da792fea3d113486c1979ef8797404936::aimoon {
    struct AIMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIMOON>(arg0, 6, b"AIMOON", b"Ai Moon", b"Beyond high-level memes crafted by tech, a place where technology turns communities into memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiew23xk37da23uk6oqodzzeaci27jui23y64qliabrjyifcrtzw2y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIMOON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


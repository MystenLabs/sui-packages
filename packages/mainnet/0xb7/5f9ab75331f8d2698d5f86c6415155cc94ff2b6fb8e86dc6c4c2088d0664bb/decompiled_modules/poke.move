module 0xb75f9ab75331f8d2698d5f86c6415155cc94ff2b6fb8e86dc6c4c2088d0664bb::poke {
    struct POKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE>(arg0, 6, b"POKE", b"PokemonGo", b"PokemonGo is the game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiewk3dji43nhusg74yfm732vxkp2odjvoxz2e7qzcuyd7ml76tbya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x70c415865e0402b02bb466a3c6f1e22e328286c65234e2025f4250b74dca59c0::poke {
    struct POKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE>(arg0, 6, b"POKE", b"PokemonGo", b"Rug token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_4043c48fd2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKE>>(v1);
    }

    // decompiled from Move bytecode v6
}


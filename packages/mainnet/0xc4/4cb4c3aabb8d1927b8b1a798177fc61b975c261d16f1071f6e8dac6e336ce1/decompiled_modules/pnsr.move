module 0xc44cb4c3aabb8d1927b8b1a798177fc61b975c261d16f1071f6e8dac6e336ce1::pnsr {
    struct PNSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNSR>(arg0, 8, b"PNSR", b"PINSUIR", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/detail/127.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PNSR>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNSR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNSR>>(v1);
    }

    // decompiled from Move bytecode v6
}


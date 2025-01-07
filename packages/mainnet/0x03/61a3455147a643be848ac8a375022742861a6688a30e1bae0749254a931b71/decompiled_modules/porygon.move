module 0x361a3455147a643be848ac8a375022742861a6688a30e1bae0749254a931b71::porygon {
    struct PORYGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORYGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORYGON>(arg0, 8, b"PORYGON", b"Porygon", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/detail/233.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PORYGON>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORYGON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORYGON>>(v1);
    }

    // decompiled from Move bytecode v6
}


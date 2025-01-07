module 0xbfbda126e008c50f52e25485782c840311b37e5d9febbf1918082128a5659fd::suicune {
    struct SUICUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUNE>(arg0, 9, b"SUICUNE", b"SUICUNE2", b"DogLegendary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/detail/245.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICUNE>(&mut v2, 123456789000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUNE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}


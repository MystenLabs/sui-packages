module 0x436c33b2241101bc2a42a21f05a8c1ee4ef5fe2e4c1240da583cb991d4016c5d::suimpert {
    struct SUIMPERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPERT>(arg0, 9, b"SUIMPERT", b"Suimpert", b"buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/detail/260.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMPERT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPERT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPERT>>(v1);
    }

    // decompiled from Move bytecode v6
}


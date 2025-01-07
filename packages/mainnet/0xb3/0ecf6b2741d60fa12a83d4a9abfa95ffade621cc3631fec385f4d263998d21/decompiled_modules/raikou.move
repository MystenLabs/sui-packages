module 0xb30ecf6b2741d60fa12a83d4a9abfa95ffade621cc3631fec385f4d263998d21::raikou {
    struct RAIKOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAIKOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAIKOU>(arg0, 9, b"RAIKOU", b"Raikou", b"Raikou on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/full/243.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAIKOU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAIKOU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAIKOU>>(v1);
    }

    // decompiled from Move bytecode v6
}


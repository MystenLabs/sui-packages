module 0x5b1b30316339f76be35a326f067e3d890dcddd38bd45a15520e1e7e26443551c::togepi {
    struct TOGEPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOGEPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOGEPI>(arg0, 9, b"TOGEPI", b"Togepi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/detail/175.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOGEPI>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOGEPI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOGEPI>>(v1);
    }

    // decompiled from Move bytecode v6
}


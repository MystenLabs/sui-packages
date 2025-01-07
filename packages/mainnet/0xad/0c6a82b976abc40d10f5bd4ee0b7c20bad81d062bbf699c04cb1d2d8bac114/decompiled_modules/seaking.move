module 0xad0c6a82b976abc40d10f5bd4ee0b7c20bad81d062bbf699c04cb1d2d8bac114::seaking {
    struct SEAKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAKING>(arg0, 9, b"SEAKING", b"Seaking", b"GEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/detail/119.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEAKING>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAKING>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAKING>>(v1);
    }

    // decompiled from Move bytecode v6
}


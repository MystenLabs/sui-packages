module 0xd7876d7609ecc3b901c8387e68e2852b8985a03343e2e6d8513dd656eb8843d6::ASUI {
    struct ASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUI>(arg0, 2, b"ASUI", b"Arcesui", b"Arceus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/full/493.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ASUI>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


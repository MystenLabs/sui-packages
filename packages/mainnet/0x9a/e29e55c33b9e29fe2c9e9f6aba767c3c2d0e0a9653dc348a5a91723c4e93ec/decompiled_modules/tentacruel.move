module 0x9ae29e55c33b9e29fe2c9e9f6aba767c3c2d0e0a9653dc348a5a91723c4e93ec::tentacruel {
    struct TENTACRUEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENTACRUEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENTACRUEL>(arg0, 9, b"TENTACRUEL", b"Tentacruel", b"SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/full/073.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TENTACRUEL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENTACRUEL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TENTACRUEL>>(v1);
    }

    // decompiled from Move bytecode v6
}


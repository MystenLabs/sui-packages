module 0x70cf99d7421a06493a38409843a60eb43acc0d9b27b9aea4aabc19e4e7c30343::kappas {
    struct KAPPAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPPAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPPAS>(arg0, 6, b"KAPPAS", b"KAPPA SUI", b"Wen Alpha ? Alpha  is here ! KAPPA on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif5b3ufeje5p37vgvb7ldeddgyqcbl75ukp6uf3wa2mexkwt3v3xa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAPPAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAPPAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


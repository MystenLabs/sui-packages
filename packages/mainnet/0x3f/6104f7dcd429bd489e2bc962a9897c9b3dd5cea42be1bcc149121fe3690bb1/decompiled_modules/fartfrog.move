module 0x3f6104f7dcd429bd489e2bc962a9897c9b3dd5cea42be1bcc149121fe3690bb1::fartfrog {
    struct FARTFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTFROG>(arg0, 6, b"FARTFROG", b"Fart Frog", b"Farley the frog has a problem he cant stop farting.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieaf2dmgessvv2i3nfpzejwexgb6e7fktnazwjkgdvgi6xoo6vt3a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FARTFROG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


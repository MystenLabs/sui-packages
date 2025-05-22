module 0x6d20dc9afd72f2b77ee0f9f97443d9f6ab35ce4c3b9b95d3afc4b6a8e9263cde::popika {
    struct POPIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPIKA>(arg0, 6, b"POPIKA", b"POPIKA SUI", b"POPS POPS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig2i7spotttvvnm6m4dfs5fqyjtfymshnkkazwymglfztjok65osi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPIKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


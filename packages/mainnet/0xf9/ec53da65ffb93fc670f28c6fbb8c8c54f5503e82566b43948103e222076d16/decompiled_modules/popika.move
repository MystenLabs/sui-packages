module 0xf9ec53da65ffb93fc670f28c6fbb8c8c54f5503e82566b43948103e222076d16::popika {
    struct POPIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPIKA>(arg0, 6, b"POPIKA", b"POPIKA SUI", b"POPS POPS POPS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig2i7spotttvvnm6m4dfs5fqyjtfymshnkkazwymglfztjok65osi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPIKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


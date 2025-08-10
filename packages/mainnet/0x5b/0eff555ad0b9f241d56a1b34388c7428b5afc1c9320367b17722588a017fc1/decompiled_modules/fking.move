module 0x5b0eff555ad0b9f241d56a1b34388c7428b5afc1c9320367b17722588a017fc1::fking {
    struct FKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKING>(arg0, 6, b"FKING", b"King Frog", b"King Frog The one true ruler of SUI Swamp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibicnwomt6rxt7nxakpzw3qn3i5jofmhqyxkqbomgomjip6qhdq4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FKING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


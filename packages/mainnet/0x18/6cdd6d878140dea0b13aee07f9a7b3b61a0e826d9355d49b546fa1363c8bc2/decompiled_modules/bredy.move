module 0x186cdd6d878140dea0b13aee07f9a7b3b61a0e826d9355d49b546fa1363c8bc2::bredy {
    struct BREDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREDY>(arg0, 6, b"BREDY", b"The Bredy", b"Unwanted by Pepe. Adopted by degenerates. BREDY runs now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiack5shvn2gnnafqa3gtno6kvuu2novo4p7xgrcqcowcp7dmjcdxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BREDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


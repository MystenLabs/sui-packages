module 0xa0ca7db1d499cf49e113623f7b0a437aa7c120f9e49a7a02e1db27ef24d508cb::chicko {
    struct CHICKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKO>(arg0, 6, b"CHICKO", b"Chicko on Sui", b"CHICKO  The Moon Bird. Roost your riches with Memecoins Degen King", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreial5ix6ejlizlb7nctmsbj4ed4fazlpuru7pfjboiudhdq6eqeg3y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHICKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


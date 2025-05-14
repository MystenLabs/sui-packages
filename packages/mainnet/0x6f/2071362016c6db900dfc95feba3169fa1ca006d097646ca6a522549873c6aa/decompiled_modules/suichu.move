module 0x6f2071362016c6db900dfc95feba3169fa1ca006d097646ca6a522549873c6aa::suichu {
    struct SUICHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHU>(arg0, 6, b"SUICHU", b"SUIKACHU", x"5355494b414348555555555520456e72696368207468656d20616c6c202c0a47657420726561647920746f20656c65637472696679207468652053554920436861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibg7jp6ydkbucxgv6d7twrohw22etum36y5xolkchaxkirlrruz4a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


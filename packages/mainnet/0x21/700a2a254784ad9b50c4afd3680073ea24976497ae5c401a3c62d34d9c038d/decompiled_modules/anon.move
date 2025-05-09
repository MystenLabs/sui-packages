module 0x21700a2a254784ad9b50c4afd3680073ea24976497ae5c401a3c62d34d9c038d::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANON>(arg0, 6, b"ANON", b"Anon SUI", b"Anon SUI is the fusion of anonymity and innovation on the SUI blockchain. Born from the spirit of the Anon community, this token brings stealth, mystery, and raw potential into one of the fastest and most scalable networks in the game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiecomyedh5lxkyumzd3pcu5nhev3vmckoo54r2ln76nnonwvcla54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


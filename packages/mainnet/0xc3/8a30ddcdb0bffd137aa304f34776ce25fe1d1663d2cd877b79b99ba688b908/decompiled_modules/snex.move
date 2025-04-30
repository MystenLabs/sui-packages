module 0xc38a30ddcdb0bffd137aa304f34776ce25fe1d1663d2cd877b79b99ba688b908::snex {
    struct SNEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEX>(arg0, 6, b"SNEX", b"SuiNex", b"SuiNex is a fast, secure, and smart digital token built on the power of the Sui blockchain. Designed for the next generation of Web3 apps, gaming, and DeFi use cases, SuiNex combines speed and scalability for a seamless on-chain experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4ufueorw3hshwqxbmmqsdar277j3bb5v7ebhhreee4oivf5bfke")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


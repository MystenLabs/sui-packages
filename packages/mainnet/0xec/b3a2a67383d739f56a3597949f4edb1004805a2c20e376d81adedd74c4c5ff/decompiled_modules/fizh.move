module 0xecb3a2a67383d739f56a3597949f4edb1004805a2c20e376d81adedd74c4c5ff::fizh {
    struct FIZH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIZH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIZH>(arg0, 6, b"FIZH", b"Sui King Fizh", b"Life is More Funny at the Sea. CONQUERING THE OCEAN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreife6dopzdsi36g262fsavrj63lyyitsnbop7g522xqccse4mjaneu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIZH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIZH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


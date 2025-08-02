module 0x577e224f40e4dae77c315e8badac6c67c09f1717d235665a283125b1a31577c1::memez {
    struct MEMEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEZ>(arg0, 6, b"MEMEZ", b"Memez on Sui", b"Join the MEMEZ revolution! Decentralized meme storage on blockchain/IPFS. Share on our social platform & participate in governance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifoo326c5qckmegs2xxfq7rx6db5eumkbyedh5tr4zdmwlzdsumv4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMEZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


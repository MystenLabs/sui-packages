module 0xa7aecd03c819ea01a3314f66df4b86f4eda4a4c3d59635a75cea45025e7c6ba8::suicha {
    struct SUICHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHA>(arg0, 6, b"SUICHA", b"Suicha Lucha", b"Put the mask on. Get the power. Fight on-chain. $SUICHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif6zu3pfwkmv7jax42vzfo67l6lkmec3d7hzw7vusiaxh75gyq7va")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICHA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


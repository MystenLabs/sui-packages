module 0x7584914193cd2b3a0482a2e5b35510f5f084c5f5e3ca05d2b41f2f7f4423926e::evofrog {
    struct EVOFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVOFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVOFROG>(arg0, 6, b"EVOFROG", b"Evofrog on SUI", b"Evolve to the Moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicjxr7idelnxdl2l7thgzczd572mgeg5lowk2rd2xklzuriw5gfdy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVOFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVOFROG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


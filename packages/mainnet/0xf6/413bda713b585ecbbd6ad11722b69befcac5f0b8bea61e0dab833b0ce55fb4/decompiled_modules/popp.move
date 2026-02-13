module 0xf6413bda713b585ecbbd6ad11722b69befcac5f0b8bea61e0dab833b0ce55fb4::popp {
    struct POPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPP>(arg0, 6, b"Popp", b"Poppy", b"Pixolend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihoq2ytst6ylvpbh6gaablpgkgezsq5iicfzgwnbptjl2iauh7bue")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


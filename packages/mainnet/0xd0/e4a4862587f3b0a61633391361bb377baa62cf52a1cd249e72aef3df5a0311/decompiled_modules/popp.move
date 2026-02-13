module 0xd0e4a4862587f3b0a61633391361bb377baa62cf52a1cd249e72aef3df5a0311::popp {
    struct POPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPP>(arg0, 6, b"Popp", b"Poxopd", b"Didiej", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihoq2ytst6ylvpbh6gaablpgkgezsq5iicfzgwnbptjl2iauh7bue")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


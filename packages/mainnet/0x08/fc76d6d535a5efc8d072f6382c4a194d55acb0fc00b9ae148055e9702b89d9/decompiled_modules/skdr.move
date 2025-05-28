module 0x8fc76d6d535a5efc8d072f6382c4a194d55acb0fc00b9ae148055e9702b89d9::skdr {
    struct SKDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKDR>(arg0, 6, b"SKDR", b"Sui Ka Drug", b"funny pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidgxuqq7qdqtii65x5pw4jnw3wplys7gula64c7xsmcpnyvyfaod4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKDR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


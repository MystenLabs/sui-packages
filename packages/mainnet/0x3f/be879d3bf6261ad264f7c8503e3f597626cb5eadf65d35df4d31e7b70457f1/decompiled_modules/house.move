module 0x3fbe879d3bf6261ad264f7c8503e3f597626cb5eadf65d35df4d31e7b70457f1::house {
    struct HOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOUSE>(arg0, 6, b"HOUSE", b"HOUSECOIN SUI", b"Everyone should have a house", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih7gampbza6tbo2vkyrtajxmw4tesogbc2zhz6xfc6w3gvy5xa3sq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOUSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x32aacea6b2af65495db2513e5255403c2ec8ae286f067e9a8c9bcf8dc511a7e2::suiguy {
    struct SUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUY>(arg0, 6, b"SUIGUY", b"THEREALSUIGUY", b"Lestgoo sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif5dmzvifgpbwxykgrilidg7me4fjr6q764optvv4cqn2sclanuxe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


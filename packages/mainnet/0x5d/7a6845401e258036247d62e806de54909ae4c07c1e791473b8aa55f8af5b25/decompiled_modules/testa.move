module 0x5d7a6845401e258036247d62e806de54909ae4c07c1e791473b8aa55f8af5b25::testa {
    struct TESTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTA>(arg0, 6, b"TESTA", b"TEST", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibma2zgay6tjr6keujadqk5d57cktltyi65f5fvzj7fic3adq2hby")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


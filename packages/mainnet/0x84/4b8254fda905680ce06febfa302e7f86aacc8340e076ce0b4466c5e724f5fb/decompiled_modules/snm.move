module 0x844b8254fda905680ce06febfa302e7f86aacc8340e076ce0b4466c5e724f5fb::snm {
    struct SNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNM>(arg0, 6, b"SNM", b"SUINAOMI", b"Just Naomi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid6kvkuqsush5lhkorvde4y3g3p7r67hnkv4dhjc3jpt3ed4ndou4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xbd760b66fa4f51084853fddffe087530da4c28def85febc02976b6ba49e8326f::jjo {
    struct JJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJO>(arg0, 6, b"JJO", b"JOLLY JOINT", b"JOLLY JOINT JOLLY JOINT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicop576i5s63df62odxdqc5uibkqgwtwij57tytf6doqgorbx3et4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JJO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


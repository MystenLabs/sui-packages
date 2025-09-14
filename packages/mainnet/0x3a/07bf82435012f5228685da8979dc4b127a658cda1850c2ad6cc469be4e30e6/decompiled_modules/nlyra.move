module 0x3a07bf82435012f5228685da8979dc4b127a658cda1850c2ad6cc469be4e30e6::nlyra {
    struct NLYRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLYRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLYRA>(arg0, 6, b"NLYRA", b"Lyra Seven", b"Lyra Seven is a character from the Nano World comic webtoon series. She is one of the most complex characters in the entire Nano World universe, so be careful when interacting with her.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaaxbicvjbtizyyxqkvxg2qp6pvv55chvnqpgwkrayj7xkql2qj7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLYRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NLYRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


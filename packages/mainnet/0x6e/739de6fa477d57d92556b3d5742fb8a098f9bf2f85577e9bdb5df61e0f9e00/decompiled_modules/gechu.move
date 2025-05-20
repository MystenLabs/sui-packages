module 0x6e739de6fa477d57d92556b3d5742fb8a098f9bf2f85577e9bdb5df61e0f9e00::gechu {
    struct GECHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECHU>(arg0, 6, b"GECHU", b"Sui Gechu", b"GECHU is a kind-hearted Pokemon in the Sui network, he always helps his friends in trouble.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib45eaq6aecqiqrb5bypn22bflvu4uxfqnbmbaptzlkhjexd4zhvq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GECHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


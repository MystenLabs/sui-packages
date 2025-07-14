module 0xe3a0a25d6020c8d937a7f1124ab7bdc23c02dbd6b730eec01f2a66a3698fefea::oank {
    struct OANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OANK>(arg0, 6, b"OANK", b"OANK INU COIN", b"A meme with memory. Powered by pain. Fueled by buyers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreietn3jozaltmffds2xxjqr23l35fwedrq4bznasrz3dvhwxb543cy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OANK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


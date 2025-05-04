module 0x2f084790360e071cc149b39887af5eb3272a13605f21ad3fb3984639d2237aa2::trsg {
    struct TRSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRSG>(arg0, 6, b"TRSG", b"The Real Sui Guy", b"The real sui guy!! We are real and remember the truth always comes out. Welcome to the new God of Sui Memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihucxy5octfns2juhjbyisxraca6dvno7kkd3i5jvsvmvbauqrvnu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRSG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


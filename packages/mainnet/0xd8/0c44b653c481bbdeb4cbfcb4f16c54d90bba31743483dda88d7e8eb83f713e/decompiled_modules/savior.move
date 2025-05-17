module 0xd80c44b653c481bbdeb4cbfcb4f16c54d90bba31743483dda88d7e8eb83f713e::savior {
    struct SAVIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVIOR>(arg0, 6, b"SAVIOR", b"Savior one coin", b"Creating coins with an old-fashioned feel SAVIOR is now here to provide happiness ancient coin and AI that once existed in the Sui Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigmkqzgxukk4uymxwdagi2virm43hkfzlpow2u7g6bxwys3kfxcbq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAVIOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


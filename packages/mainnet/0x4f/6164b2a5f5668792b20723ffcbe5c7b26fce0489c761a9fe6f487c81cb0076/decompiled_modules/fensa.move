module 0x4f6164b2a5f5668792b20723ffcbe5c7b26fce0489c761a9fe6f487c81cb0076::fensa {
    struct FENSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENSA>(arg0, 6, b"FENSA", b"Fennec of the Sahara", b"FENSA is a community token on the Sui blockchain, inspired by the fennec fox of the Algerian Sahara  a symbol of cleverness and resilience. It celebrates desert culture and connects people through Web3 and shared values.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig3yrqn4j7m3q7rh3zfhze7x6yivfjis4dmpipezll5kiimq4idtm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FENSA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


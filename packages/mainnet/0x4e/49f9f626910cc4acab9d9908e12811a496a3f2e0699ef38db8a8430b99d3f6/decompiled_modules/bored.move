module 0x4e49f9f626910cc4acab9d9908e12811a496a3f2e0699ef38db8a8430b99d3f6::bored {
    struct BORED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORED>(arg0, 6, b"BORED", b"Bored Boyz Club", b"Bored Boyz Club Memecoin On sui with real Utility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibuxmb64uknq7y5cyeenmnugr3iunu7xo75ssbkydah55thno7u5y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BORED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


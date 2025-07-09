module 0xf3a7470c63430871e864b0dfe52121c0a8a73b1968096ec11873a36edbfbdf56::dank {
    struct DANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANK>(arg0, 6, b"DANK", b"DANK Coin", x"466f7220616c6c2074686520546f6b6572732f4e65726420636f6d6d756e6974792e200a576520546f6b6520696e2050656163650a2444414e4b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifakqkqhh64nege3qo7ne5exw3w6adrc3uvvcsem26bjqpzauga4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DANK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


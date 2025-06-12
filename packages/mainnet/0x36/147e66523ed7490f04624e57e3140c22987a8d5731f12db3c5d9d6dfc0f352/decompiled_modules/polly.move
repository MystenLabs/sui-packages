module 0x36147e66523ed7490f04624e57e3140c22987a8d5731f12db3c5d9d6dfc0f352::polly {
    struct POLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLLY>(arg0, 6, b"POLLY", b"Pengu Wife", b"PENGU WIFE on SUI | POLLY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiesias6auenhubjyeaecb7rvvzufwuepxvayffhwi4uer2ejwdabm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POLLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


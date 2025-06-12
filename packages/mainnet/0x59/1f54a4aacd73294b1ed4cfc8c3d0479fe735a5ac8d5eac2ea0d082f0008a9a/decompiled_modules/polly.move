module 0x591f54a4aacd73294b1ed4cfc8c3d0479fe735a5ac8d5eac2ea0d082f0008a9a::polly {
    struct POLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLLY>(arg0, 6, b"POLLY", x"50656e6775e28099732057696665", b"PENGU WIFE on SUI | POLLY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiesias6auenhubjyeaecb7rvvzufwuepxvayffhwi4uer2ejwdabm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POLLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


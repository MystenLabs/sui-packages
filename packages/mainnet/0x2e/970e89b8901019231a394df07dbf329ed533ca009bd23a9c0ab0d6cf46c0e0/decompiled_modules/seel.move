module 0x2e970e89b8901019231a394df07dbf329ed533ca009bd23a9c0ab0d6cf46c0e0::seel {
    struct SEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEL>(arg0, 6, b"SEEL", b"Seel on SUI", b"Seel is the cutest seal on sui, Born from a passion for both cute marine creatures and blockchain technology, SEEL emerged as the undisputed cutest seal-themed token in the SUI ecosystem. Inspired by beloved pocket monsters and the playful spirit of the crypto community, we're building more than just a token  we're creating an entire experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidownuyhbqlnfcxc43l2rclwxdx4yzirfn2ih4ufn5cvq7belypbm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


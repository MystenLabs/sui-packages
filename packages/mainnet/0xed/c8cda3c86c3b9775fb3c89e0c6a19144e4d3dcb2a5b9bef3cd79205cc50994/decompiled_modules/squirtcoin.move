module 0xedc8cda3c86c3b9775fb3c89e0c6a19144e4d3dcb2a5b9bef3cd79205cc50994::squirtcoin {
    struct SQUIRTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRTCOIN>(arg0, 6, b"Squirtcoin", b"Squirt coin", x"546865207765747465737420636f696e206f6e20746865207765747465737420636861696e2e0a0a4e6f2054472c206e6f20636162616c2c206a757374207371756972742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibakyxapdsvhtbsusf5ivdmeh6aetxnbmblqqpqagbvs2rrlxp764")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUIRTCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


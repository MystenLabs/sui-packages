module 0x8962a30968e901da9d26e78835683fc5b43f976bb00445ba7190c742497bea05::mola {
    struct MOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLA>(arg0, 6, b"Mola", b"Mola Mola on Sui", b"Mola is the Great definition of not giving a fuck. Even if a sealion bit his Head. He still doesnt give a Fuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibzr4rqulymrjppeufuk434cnd47gkexxnawocrnpupl6ob2cwsgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xc3b59a4c1a8eedea45371ca1af3512fca800c3793f48b97ff5aff7b9943f28e2::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 6, b"BCAT", b"Banana Cat", b"Test banana cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidielnavliimk4x42tlzc2thghd5wif2p7dhgavzbkmb4hp5yrmp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xe19b3371f98606d459077b7ecc3e787facd6c88c706612d836d5668247f44531::test3 {
    struct TEST3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST3>(arg0, 6, b"Test3", b"TST3", b"Haha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigujg7bywqxjvehajb2iim45muyav3bwqerc35ginhq3hr2l3ywhe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


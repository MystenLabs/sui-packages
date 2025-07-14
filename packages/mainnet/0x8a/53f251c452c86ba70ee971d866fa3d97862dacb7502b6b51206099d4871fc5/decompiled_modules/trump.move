module 0x8a53f251c452c86ba70ee971d866fa3d97862dacb7502b6b51206099d4871fc5::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"Donald Trump Sui", b"The TRUMP token is designed to fuel the meme economy with bold, brash, and unapologetic energy, just like its namesake. Built on the Sui blockchain, it ensures fast, secure, and low cost transactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicngs6f6y6jykesurkwh7yjbkn4oy5i5wetabznlq6olwzpzdcfs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


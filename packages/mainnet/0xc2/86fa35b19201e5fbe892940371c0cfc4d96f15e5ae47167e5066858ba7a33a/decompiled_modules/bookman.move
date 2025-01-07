module 0xc286fa35b19201e5fbe892940371c0cfc4d96f15e5ae47167e5066858ba7a33a::bookman {
    struct BOOKMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOKMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOKMAN>(arg0, 6, b"Bookman", b"Bookman AI Agent", b"The Baddest Crypto on the Sui Blockchain. The Bookman AI created by Crypto Secret X first released on Solana now brings his AI Agent to Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bookman2_6a4b1d6be0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOKMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOKMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


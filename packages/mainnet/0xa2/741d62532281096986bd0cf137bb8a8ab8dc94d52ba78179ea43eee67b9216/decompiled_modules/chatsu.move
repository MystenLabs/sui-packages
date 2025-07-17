module 0xa2741d62532281096986bd0cf137bb8a8ab8dc94d52ba78179ea43eee67b9216::chatsu {
    struct CHATSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHATSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHATSU>(arg0, 6, b"ChatSU", b"Chat Anonymous", b"Chat Anonymous on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiceoo5p2mas4nlgdwzhlyw2me4zci2uatzymznltbgy2ozs5opzri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHATSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHATSU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


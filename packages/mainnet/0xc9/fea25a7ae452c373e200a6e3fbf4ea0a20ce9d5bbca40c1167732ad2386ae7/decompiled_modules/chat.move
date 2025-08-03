module 0xc9fea25a7ae452c373e200a6e3fbf4ea0a20ce9d5bbca40c1167732ad2386ae7::chat {
    struct CHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAT>(arg0, 6, b"CHAT", b"ChatSui", b"Where Meme Coin Magic Meets Seamless Chatting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibptfhgc4ce6h75zro3goslom5ta76qlacwgz5gkkhwdswkk23jzy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


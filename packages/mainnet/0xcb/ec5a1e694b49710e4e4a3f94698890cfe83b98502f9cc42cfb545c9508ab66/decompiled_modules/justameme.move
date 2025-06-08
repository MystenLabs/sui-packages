module 0xcbec5a1e694b49710e4e4a3f94698890cfe83b98502f9cc42cfb545c9508ab66::justameme {
    struct JUSTAMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTAMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTAMEME>(arg0, 6, b"JustAMeme", b"JUST A SUI TOKEN", b"Welcome to Just A Sui Token the ultimate meme coin on the Sui blockchain that says it like it is. We only need ONE meme coin and its called JUST A SUI TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiamgpfxel3zoh3brbxzn7nupsm3rq57cf7kn5aek4ctvyura7wov4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTAMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUSTAMEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


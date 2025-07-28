module 0x41d80a1b1cdd5a9bfce8c6e1b55d6bb35035073355125b17d4b693bba7207401::woot {
    struct WOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOT>(arg0, 6, b"WOOT", b"WootHub", b"Woot is a blue owl that became real. Not a logo, not a PFP a living meme with feathers, moves and a mouth. He talks, he posts, he flexes. He screamed Woot Woot once. and it never stopped.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia447bpxtrzukjrtjvfmps74zhwhfu4dl3n5xqe5r7oyodpahr7oi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x7e8bb443f34987fb5c223cb251f4da6163d0c2ec5e1ceeaa8dbbee55165d4aea::sui_rock {
    struct SUI_ROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_ROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_ROCK>(arg0, 6, b"SUI ROCK", b"SUI ROCK", b"Ape Rocks - first rocks on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qme8AVsruhVUK64ndGjkvQV8kETbDz6csMpxdCcVU3rqZX")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUI_ROCK>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUI_ROCK>(17616276936109271824, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


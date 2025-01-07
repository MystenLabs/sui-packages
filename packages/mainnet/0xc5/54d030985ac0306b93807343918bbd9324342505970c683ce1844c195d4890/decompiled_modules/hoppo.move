module 0xc554d030985ac0306b93807343918bbd9324342505970c683ce1844c195d4890::hoppo {
    struct HOPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPO>(arg0, 6, b"Hoppo", b"Hoppopotamus", b"First Hippopotamus on SUI! Hoppopotamus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmbyWg4TzUd5SXjEXCtiuednDfKjNRSgaR9kDP4L9ZQiKs")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPPO>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPPO>(4264317125836739478, v0, v1, 0x1::string::utf8(b"https://x.com/Hoppopotamus_"), 0x1::string::utf8(b"https://www.hoppopotamus.xyz/"), 0x1::string::utf8(b"https://t.me/HoppopotamusPORTAL"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


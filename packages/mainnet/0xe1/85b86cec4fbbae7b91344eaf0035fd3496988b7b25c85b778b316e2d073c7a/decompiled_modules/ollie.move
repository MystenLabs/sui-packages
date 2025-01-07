module 0xe185b86cec4fbbae7b91344eaf0035fd3496988b7b25c85b778b316e2d073c7a::ollie {
    struct OLLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLLIE>(arg0, 6, b"Ollie", b"Rockstar Otter", b"Ollie To A Dolly $$$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmYfPDSwukxiDGbfiKBm1Tg7qLYJvR76Am5yUAHF2vk58Z")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<OLLIE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<OLLIE>(13675975005683101415, v0, v1, 0x1::string::utf8(b"https://x.com/Rockstarotter?t=dQ-DzzYmwKpdjuyfZTov8Q&s=09"), 0x1::string::utf8(b"https://www.rockstarotter.com/"), 0x1::string::utf8(b"https://t.me/rockstarotter"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


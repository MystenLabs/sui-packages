module 0xf221f685b78721105507881eb9e477ab3ee1f638095ab839b74db318e27000b1::cock {
    struct COCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCK>(arg0, 6, b"COCK", b"Cock", b"The first visit in https://hop.ag/fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmTMTAPxfEC9Fu9rgS7qGZsE3Bt49BnTkDc8yK11fbP1ig")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<COCK>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<COCK>(4160157249068176415, v0, v1, 0x1::string::utf8(b"https://x.com/hopaggregator"), 0x1::string::utf8(b"https://sui.io/"), 0x1::string::utf8(b"https://t.me/s/SuiGlobalOfficial"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


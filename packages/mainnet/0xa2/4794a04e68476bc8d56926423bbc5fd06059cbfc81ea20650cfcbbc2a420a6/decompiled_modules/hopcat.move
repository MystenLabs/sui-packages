module 0xa24794a04e68476bc8d56926423bbc5fd06059cbfc81ea20650cfcbbc2a420a6::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"Hopcat", b"Hopcat", b"Hopcat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmRa3XL5YZQhDzQQyyEzCH1Q9aGaDEGe6N1TXkwyeNDRtP")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPCAT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPCAT>(3765496235642475832, v0, v1, 0x1::string::utf8(b"https://x.com/HopCatSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/HopCatSui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


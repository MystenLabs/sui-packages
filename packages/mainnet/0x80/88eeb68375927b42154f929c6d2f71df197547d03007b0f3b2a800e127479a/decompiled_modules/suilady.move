module 0x8088eeb68375927b42154f929c6d2f71df197547d03007b0f3b2a800e127479a::suilady {
    struct SUILADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILADY>(arg0, 6, b"SUILADY", b"The Queen Of Sui Ocean", b"The Queen Of Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQeHxQXeguR8oeqf1zwciNn51oKRfkCszfBLwraBBhhB5")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUILADY>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUILADY>(8735947244775654755, v0, v1, 0x1::string::utf8(b"https://x.com/SuiLady_"), 0x1::string::utf8(b"https://sui-lady.fun/"), 0x1::string::utf8(b"https://t.me/SuiLady_Portal"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


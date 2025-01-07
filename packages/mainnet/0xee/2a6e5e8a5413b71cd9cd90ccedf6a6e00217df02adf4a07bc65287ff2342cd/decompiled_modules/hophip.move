module 0xee2a6e5e8a5413b71cd9cd90ccedf6a6e00217df02adf4a07bc65287ff2342cd::hophip {
    struct HOPHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPHIP>(arg0, 6, b"HOPHIP", b"Hop Hip", b"hophip.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmPwgfqwdxAPAh9kkRHG6ZQ4XY2xYJr8TEzxY8kmA4h3MM")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPHIP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPHIP>(5453324464764556977, v0, v1, 0x1::string::utf8(b"https://x.com/hophip_sui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


module 0xe938675eca6a01b5a3f20ec9c5d537a3c8986438b38cc8cbc3e9ea1c9db320a9::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"TRUMP", b"RULE THE WORLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qmem6Q1rCNjf32qUWmRhENBP5e86Y3prNawHSubAiUJDXj")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<TRUMP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<TRUMP>(13498956485724652032, v0, v1, 0x1::string::utf8(b"https://x.com/trump"), 0x1::string::utf8(b"https://trump.sui.xyz/"), 0x1::string::utf8(b"https://t.me/trumpSUI"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


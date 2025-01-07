module 0x5c76d06037c5f23af4b9bf9eb814364ee9e02bb1122ede5e2b2e58804c1f33b0::bonkman {
    struct BONKMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKMAN>(arg0, 6, b"bonkman", b"bonkman", b"Hello, I am Bonkman.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmWn6rXpcFnNjaZzGBaPKDz6yYqnW2H6AE82DHnUPDP4J6")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<BONKMAN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<BONKMAN>(13265987498314773885, v0, v1, 0x1::string::utf8(b"https://x.com/bonkman22"), 0x1::string::utf8(b"https://hop.ag"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


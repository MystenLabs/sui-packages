module 0x751b0e929c0d1dd77548dc31f2e2ccca736a00c0de3d1327f193e4d7521f3f0a::face {
    struct FACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACE>(arg0, 6, b"FACE", b"Suiface", b"This is my face.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmUX2VTdjCJig67wWrH5t3MVxV521cv5w1CX9jTXt6wWqs")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<FACE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<FACE>(18156722176617122146, v0, v1, 0x1::string::utf8(b"https://x.com/Suifaceishere"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


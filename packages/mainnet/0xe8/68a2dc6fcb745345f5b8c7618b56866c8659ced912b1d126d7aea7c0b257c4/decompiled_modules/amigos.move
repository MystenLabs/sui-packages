module 0xe868a2dc6fcb745345f5b8c7618b56866c8659ced912b1d126d7aea7c0b257c4::amigos {
    struct AMIGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMIGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMIGOS>(arg0, 6, b"AMIGOS", b"Amigos", x"546865206d656d6520636f696e206f6e207375692074686174e280997320736f206c6169642d6261636b2c206974e28099732070726163746963616c6c7920686f72697a6f6e74616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmbX9NveFjtYhDuetVw1RAXQbQAMHpB7W5ygZ1RTTjYHed")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<AMIGOS>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<AMIGOS>(2444112782616110644, v0, v1, 0x1::string::utf8(b"https://x.com/Amigosmemecoin"), 0x1::string::utf8(b"https://amigosofficial.com/"), 0x1::string::utf8(b"https://t.me/+XPBjZLILtokwMWFh/"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


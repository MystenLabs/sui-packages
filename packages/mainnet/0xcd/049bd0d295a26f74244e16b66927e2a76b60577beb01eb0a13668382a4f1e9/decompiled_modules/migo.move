module 0xcd049bd0d295a26f74244e16b66927e2a76b60577beb01eb0a13668382a4f1e9::migo {
    struct MIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGO>(arg0, 6, b"Migo", b"Amigos", b"Welcome to Amigos, the meme coin that's so laid-back, it's practically horizontal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmbX9NveFjtYhDuetVw1RAXQbQAMHpB7W5ygZ1RTTjYHed")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<MIGO>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<MIGO>(3497251884567413383, v0, v1, 0x1::string::utf8(b"https://x.com/Amigosmemecoin"), 0x1::string::utf8(b"https://amigosofficial.com"), 0x1::string::utf8(b"https://t.me/+XPBjZLILtokwMWFh"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


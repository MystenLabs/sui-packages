module 0x3cd3a9681a2cef93e9d34dce6d4bdff4061bc9a13d6b67231d5cad2bf6af3a36::heppo {
    struct HEPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEPPO>(arg0, 6, b"heppo", b"suiheppo", b"Your heppo with a beautiful smile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmT9cAytovJL78nHHhq6cJJRiQPXNgaj9aLg8DjuRkiqKq")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HEPPO>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HEPPO>(3271612194563409382, v0, v1, 0x1::string::utf8(b"https://x.com/suiheppo"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


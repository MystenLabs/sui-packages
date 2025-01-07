module 0xf4a61fc117400c8456a90ff6f5a2d3064a8082c7c675f35f0c662e5dc56fbf92::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"REX", b"SUIREX", b"Something big and blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmdHT3ngjCqfn7wq8n668cnrqkaJ8YFQwt5GAghiQ9STuq")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<REX>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<REX>(11960756734046356523, v0, v1, 0x1::string::utf8(b"https://x.com/suirex_"), 0x1::string::utf8(b"https://suirex.xyz/"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


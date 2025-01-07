module 0x15c5ab249affeaea72bf47e21fd680c86ac032d5f09fb60876fc06701ba9dc87::volo {
    struct VOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLO>(arg0, 6, b"Volo", b"Volo", b"DAO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSazt7U4M5rYv7RLdf7YXwKAPVdYqSaADXnZmhGWribUu")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<VOLO>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<VOLO>(4007731753386185946, v0, v1, 0x1::string::utf8(b"https://x.com/volo_sui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


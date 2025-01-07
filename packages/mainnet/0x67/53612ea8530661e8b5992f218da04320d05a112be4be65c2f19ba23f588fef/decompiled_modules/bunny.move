module 0x6753612ea8530661e8b5992f218da04320d05a112be4be65c2f19ba23f588fef::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 6, b"BUNNY", b"HopBunnyonsui", b"HOP BUNNY THE FIRST BUNNY ON hopaggregator & suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmbkLAsbAgonB67EgvfWjLD4RPzyW8WZM9Jjn5qArwjQe5")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<BUNNY>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<BUNNY>(13461271161283057843, v0, v1, 0x1::string::utf8(b"https://x.com/HopBunnyonsui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


module 0x607e010aa30291b1f6e96d53293b76c8a081488ca0d18cbdfa9bbe5a1720ff3d::suipe {
    struct SUIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPE>(arg0, 6, b"SUIPE", b"PEPE ON SUI", b"PEPE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmRxbiTGcMUYKGZaKPZSLFSSKUNebRcQ5PEvQ1oqtkUGBF")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUIPE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUIPE>(12991616608573941279, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


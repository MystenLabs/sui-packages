module 0xde6b7bd017a1e2fb43053abb08681f70356408f6c31ba1b6df2a5912b57d751::prts {
    struct PRTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRTS>(arg0, 6, b"PRTS", b"Pirates", b"First Pirates Token On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmVypqKBU4pLBbDZxo9P1dcVEUHneLpf27DmfKS6Q8Mdnu")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<PRTS>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<PRTS>(14751114033922383915, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


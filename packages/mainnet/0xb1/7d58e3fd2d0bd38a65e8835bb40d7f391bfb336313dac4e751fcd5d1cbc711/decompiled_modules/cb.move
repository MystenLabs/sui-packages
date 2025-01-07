module 0xb17d58e3fd2d0bd38a65e8835bb40d7f391bfb336313dac4e751fcd5d1cbc711::cb {
    struct CB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CB>(arg0, 6, b"CB", b"t-CallBoyZ", b"Governance token for the CallBoyZ sub-ecosystem on SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmZRMjD582M84ZRZBMkmAmzXQV5vLTbLqbt7CL27nuTXYN")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<CB>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<CB>(10726551588466155506, v0, v1, 0x1::string::utf8(b"https://x.com/TheCallboyz"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


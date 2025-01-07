module 0xb8344f8319e0e896ed460e2be60296f961198bdc7fb5b7a75aa9ffb86511b848::tip {
    struct TIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TIP>(arg0, 1994257813040331297, b"Tipsy", b"TIP", b"Boozing my sorrows in the oceans deep, a narwhal adrift in sorrows keep!", b"https://images.hop.ag/ipfs/QmdYHjjV9PzbHCbeDnzAvbpRmYfzb7oaRPhrtGZB3h3hoQ", 0x1::string::utf8(b"https://x.com/tipsyonsui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


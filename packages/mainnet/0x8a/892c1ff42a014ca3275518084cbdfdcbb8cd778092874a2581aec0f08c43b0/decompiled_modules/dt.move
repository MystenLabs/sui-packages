module 0x8a892c1ff42a014ca3275518084cbdfdcbb8cd778092874a2581aec0f08c43b0::dt {
    struct DT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DT>(arg0, 14046013618889207010, b"DropToken", b"DT", b"A drop in the ocean of meme coins, but a geyser of good times.", b"https://images.hop.ag/ipfs/QmcZ34wH2MZPgd7JgXpzaR3CWyX8GJBrUaGsRonDncjWAt", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


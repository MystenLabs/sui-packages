module 0xa68f0350278793bd1744a22fb649e5e2985f60b271fe1debee7382cf5909bec6::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DOGE>(arg0, 16828290708325400796, b"Department Of Government Efficiency On Sui", b"DOGE", b"Department of Government Efficiency - Led by Elon Musk and Vivek Ramaswamy", b"https://images.hop.ag/ipfs/QmcvjJKcpCq8iAnKsTjZJsmDZda2JH5KwMx36xXhyW49vM", 0x1::string::utf8(b"https://x.com/doge_eth_gov"), 0x1::string::utf8(b"https://dogegov.com/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


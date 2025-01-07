module 0xb29f76d6c11a39f513d0bd0bfab342551a37237c32d1e9455b9c4dbefede779::suirup {
    struct SUIRUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIRUP>(arg0, 5265771477929410918, b"Suirup", b"SUIRUP", b"ATTENTION: Become one of the early supporters and together we will build the leading meme coin launchpad on SUI, which gives the community a fair share of the infrastructure investment. True to the motto: By the community and for the community. We'll be disrupting wash trades with decentralized identities, branding features like print-on-demand and Shopify Stores connections, meme coin DAOs for more fairness, meme coin token vaults for future-proof launchpad coins and more. In addition, we plan to develop the most advanced crypto analytics tools for meme coins and beyond, as there is too much incongruent data. We can start immediately as a DAO and especially fair for everyone.", b"https://images.hop.ag/ipfs/Qme6JauojR4cQic4c45VwaPahgPe2hWMHvcw9KHNUbyBJP", 0x1::string::utf8(b"https://x.com/Renegad94696917"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


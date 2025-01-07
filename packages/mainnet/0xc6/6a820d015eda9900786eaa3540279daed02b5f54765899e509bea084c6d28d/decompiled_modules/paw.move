module 0xc66a820d015eda9900786eaa3540279daed02b5f54765899e509bea084c6d28d::paw {
    struct PAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAW, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PAW>(arg0, 14225115492366502362, b"PAW COIN", b"PAW", b"Every dog licking his PAW. Only for entertainment.", b"https://images.hop.ag/ipfs/QmcXVNpb87ErLD7KyZ2Fh4NBAQu8qTg44BMiqJd7paRCwA", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


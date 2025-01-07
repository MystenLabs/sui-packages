module 0x9c2b471fa65130e437061ab20a766831b9a481dfc019e5d568cb101efa186b0e::dad {
    struct DAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DAD>(arg0, 16162641530954058335, b"DAd", b"DAD", b"d", b"https://images.hop.ag/ipfs/QmUXzJi8wkJSCQPE3xfzeu9dfdeat2AYe2rLurWczhGxzP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


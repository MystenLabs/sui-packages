module 0x79602be0a5306438775bf32cfbf0951d7863b3a549da5a665da18251ad2c9379::dad {
    struct DAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<DAD>(arg0, 13288872062300539556, b"da", b"DAD", b"d", b"https://images.hop.ag/ipfs/QmUXzJi8wkJSCQPE3xfzeu9dfdeat2AYe2rLurWczhGxzP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


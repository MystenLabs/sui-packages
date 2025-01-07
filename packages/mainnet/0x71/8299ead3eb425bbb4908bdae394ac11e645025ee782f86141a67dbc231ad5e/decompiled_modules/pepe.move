module 0x718299ead3eb425bbb4908bdae394ac11e645025ee782f86141a67dbc231ad5e::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PEPE>(arg0, 5981551599050221297, b"BIG PEPE", b"PEPE", b"i am here to knockout $PEPE training starts today. Get ready !", b"https://images.hop.ag/ipfs/QmdYeQ6mT4ox1W5az8w5xHwHWG3s1dKeWYkEAFWAEnwkpd", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


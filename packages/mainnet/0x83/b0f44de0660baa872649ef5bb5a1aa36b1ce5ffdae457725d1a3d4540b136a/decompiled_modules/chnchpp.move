module 0x83b0f44de0660baa872649ef5bb5a1aa36b1ce5ffdae457725d1a3d4540b136a::chnchpp {
    struct CHNCHPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHNCHPP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CHNCHPP>(arg0, 9916684099043136923, b"CHIN CHOPPA", b"CHNCHPP", b"FREASH MEAT", b"https://images.hop.ag/ipfs/QmNYQiXka9KYx7dtDHQ17mi8WkKCQznSs7xuc6bq43KLrz", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


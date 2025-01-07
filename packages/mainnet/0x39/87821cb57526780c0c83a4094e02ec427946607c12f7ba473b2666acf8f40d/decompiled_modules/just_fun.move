module 0x3987821cb57526780c0c83a4094e02ec427946607c12f7ba473b2666acf8f40d::just_fun {
    struct JUST_FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUST_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<JUST_FUN>(arg0, 4968491157464747281, b"Just understand simply trade it", b"JUST FUN", b"just trade it for fun how good are you", b"https://images.hop.ag/ipfs/QmchfYN7KAVECndQFABeeHLZbWHkpP6CbXeubpRPuQHpzX", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


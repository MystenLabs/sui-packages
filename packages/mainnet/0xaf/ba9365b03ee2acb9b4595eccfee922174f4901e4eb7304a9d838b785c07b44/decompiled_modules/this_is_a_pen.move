module 0xafba9365b03ee2acb9b4595eccfee922174f4901e4eb7304a9d838b785c07b44::this_is_a_pen {
    struct THIS_IS_A_PEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: THIS_IS_A_PEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<THIS_IS_A_PEN>(arg0, 188775467315867582, b"pen", b"this is a pen", b"this pen is big", b"https://images.hop.ag/ipfs/QmZmF3p7zWKAWomjgc2fxhXEJtcTNjQo9sUr9unqQzvWbK", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


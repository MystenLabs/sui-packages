module 0xc765707bfa3b3efb32644b8c336dd46e92d051fd305c3badf49e69583baf343c::xguy {
    struct XGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: XGUY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<XGUY>(arg0, 3045214423880768771, b"XmasGuy", b"XGuy", x"5265616c20786d6173204368696c6c477579206f6e20537569f09f98b2", b"https://images.hop.ag/ipfs/Qmaj3gJkpsBUBuV5XXCLmE5jER9pdAik5jD2uoQLjtBb5B", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


module 0x7bd1803486f9c8ab8229339b5c80aee207adaa3550a4a9ca4bffb3a0601147bd::suiuni {
    struct SUIUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUNI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIUNI>(arg0, 13596261234639429862, b"SUIUniverse", b"SUIUni", b"SUI Universe", b"https://images.hop.ag/ipfs/QmeL4DnjNBxomfFkGDpvNBjUGeRKQ21F57wCEbzTtmyS9n", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


module 0x21e5ae4206872c331d2dd0afc2402670cadd7f5b3b882edcb075982fd208ba0b::melf {
    struct MELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MELF>(arg0, 4143793448386870443, b"Mary Elf", b"MELF", b"An Elf called Mary", b"https://images.hop.ag/ipfs/QmRyMaVipUwGnatKndQhtZK9EP7SACLubpucJipBfskQ8q", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


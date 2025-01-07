module 0xccc5a56846c16668cf1e7b95c6000ef35c0852d5022d3b4a76f927b1d2253bf9::mike {
    struct MIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MIKE>(arg0, 973070699495201441, b"mike", b"MIKE", b"hehe", b"https://images.hop.ag/ipfs/Qmax4eTfYSw4MvKD7s7qojy2CGBSR8SEtjuNn8v5BDo2BR", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


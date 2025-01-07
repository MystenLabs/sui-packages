module 0x484d045a1056fdaf52ae5f437d308c11dd0d639cf1d48093eb20fd003a3895b0::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PEPE>(arg0, 13496152662919316333, b"PEPE", b"PEPE", b"https://t.me/SuiPepeChain", b"https://images.hop.ag/ipfs/QmNPGxNPDQRq2YA2LGF4JRn7hve1BG8eDWpQjXhSLFUjPw", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


module 0x159eb78be3ddff249d107148dbd64285cfdf1055c61c1a7c512cbc0d616b6832::p_f {
    struct P_F has drop {
        dummy_field: bool,
    }

    fun init(arg0: P_F, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<P_F>(arg0, 323643230661887322, b"Peanut&Fred", b"P&F", b"RIP peanut & fred", b"https://images.hop.ag/ipfs/QmfQaZf6DywoFbKVP49v2SsmbAHctDqePNP6tupUguez2K", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


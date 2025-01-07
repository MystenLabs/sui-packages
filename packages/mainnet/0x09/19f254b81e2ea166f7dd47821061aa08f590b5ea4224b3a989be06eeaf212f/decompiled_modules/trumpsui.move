module 0x919f254b81e2ea166f7dd47821061aa08f590b5ea4224b3a989be06eeaf212f::trumpsui {
    struct TRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TRUMPSUI>(arg0, 17649686104866794261, b"Pure Trump", b"TRUMPSUI", b"No gimmicks. Just pure Trump. Top coin on Sui.", b"https://images.hop.ag/ipfs/QmUstRuoyUmDMpxAdfMuKxkGRAXyLU7LwpHk4Hx1jAWxNm", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


module 0x7e92467046a0c6087040b78aa32f3030a0992d7e1e043a415833c9ce50511b6d::meisui {
    struct MEISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEISUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MEISUI>(arg0, 8844761860270180372, x"4d656953756920e6b2a1e6b0b4", b"MEISUI", x"4d65692053756920e6b2a1e6b0b43a204e6f205355492c206e6f20776f7272696573e280946a7573742073636172636974792c20736d696c65732c20616e64206472792068756d6f722e", b"https://images.hop.ag/ipfs/QmT9gr8ChoXfLtRcBpizkxVhJaVyDo6Z4sArbe61AUMhjc", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


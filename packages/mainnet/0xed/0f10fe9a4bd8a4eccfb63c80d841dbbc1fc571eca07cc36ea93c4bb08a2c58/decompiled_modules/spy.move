module 0xed0f10fe9a4bd8a4eccfb63c80d841dbbc1fc571eca07cc36ea93c4bb08a2c58::spy {
    struct SPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SPY>(arg0, 10655120699040243759, b"Suipsy", b"Spy", x"5065616b20696e746f2074686520537769726c206f66205375692050737963686f6c6f67792e200a556e6465727374616e6420496e7370697265202620456e6c69676874656e20796f757273656c66200a696e206120776f726c64206f66206d696e642062656e64696e67204761696e732e", b"https://images.hop.ag/ipfs/QmXEXrbzyVvbfoKzfTmezatCbyExfPR7JB3bYGY64QivA9", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


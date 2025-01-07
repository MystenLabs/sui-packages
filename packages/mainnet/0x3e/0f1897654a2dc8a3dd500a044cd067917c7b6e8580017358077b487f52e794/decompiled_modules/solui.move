module 0x3e0f1897654a2dc8a3dd500a044cd067917c7b6e8580017358077b487f52e794::solui {
    struct SOLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SOLUI>(arg0, 394878876583476720, b"SOLUI", b"SOLUI", b"SUI/SOL", b"https://images.hop.ag/ipfs/QmVvpAeydDZ9iT2MuACZM3PDGRMBkXkTXFdKVmcVM9eXvV", 0x1::string::utf8(b"https://x.com/soluifdn"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


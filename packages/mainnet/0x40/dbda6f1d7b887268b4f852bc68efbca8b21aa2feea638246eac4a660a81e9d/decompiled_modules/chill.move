module 0x40dbda6f1d7b887268b4f852bc68efbca8b21aa2feea638246eac4a660a81e9d::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CHILL>(arg0, 5124375778676328101, b"chill", b"CHILL", b"Buy $SUI and chill.", b"https://images.hop.ag/ipfs/QmfPpKxfSZEZYMirAckRajCwZ5PDwEdgatNuCJSQBtasMS", 0x1::string::utf8(b"https://x.com/_smkotaro/status/1860067665332830547"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


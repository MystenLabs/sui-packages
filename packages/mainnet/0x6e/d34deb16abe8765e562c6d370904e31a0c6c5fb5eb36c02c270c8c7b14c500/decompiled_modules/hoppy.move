module 0x6ed34deb16abe8765e562c6d370904e31a0c6c5fb5eb36c02c270c8c7b14c500::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPPY>(arg0, 584506164765727997, b"Hoppy Rabbit", b"hoppy", x"f09f9087486170707920486f70707920526162626974206f6e20245355492c200a0a24484f505059206973207374696c6c20686572650a0a4e6577206578706c6f73696f6e2e204e6f7468696e672063616e2073746f702024484f5050592e", b"https://images.hop.ag/ipfs/QmU5j87uTWcSDSh1cHcqrL1rQsZKuxhDoressEutUaaNhr", 0x1::string::utf8(b"https://x.com/hoppyonsui_x"), 0x1::string::utf8(b"https://hoppyonsui.xyz"), 0x1::string::utf8(b"https://t.me/Hoppyonsui"), arg1);
    }

    // decompiled from Move bytecode v6
}


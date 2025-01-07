module 0xc2716c2d45c8e2f0ad108224907e92709a964220cf3ef46fb81f4f7ed3d4dad1::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"cat", b"HopCat", x"44696420796f75207365652077686f206b6e6f636b6564206f6e2074686520646f6f723f0a546869732069732074686520486f7046756e200a40486f7041676772656761746f720a20746861742077696c6c206c61756e6368206f6e204f63746f62657220313220616e6420776527726520676f696e672077697468206974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmWBx34wFTPcn8u2RbT74MgrKZFcbssptPYZWZhHQM3oVt")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<CAT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<CAT>(17223177709474014084, v0, v1, 0x1::string::utf8(b"https://x.com/hopcatsui?s=21"), 0x1::string::utf8(b"https://t.co/30bs1JcpoA"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


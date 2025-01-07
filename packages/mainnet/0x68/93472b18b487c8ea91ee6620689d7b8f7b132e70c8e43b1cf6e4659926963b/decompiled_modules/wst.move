module 0x6893472b18b487c8ea91ee6620689d7b8f7b132e70c8e43b1cf6e4659926963b::wst {
    struct WST has drop {
        dummy_field: bool,
    }

    fun init(arg0: WST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WST>(arg0, 6, b"WST", b"We Stand Together", x"576520617265207468652070656f706c65206f662063727970746f0a576520726570726573656e74206120647265616d2e204120726562656c6c696f6e2e20412063617573652067726561746572207468616e20616e79206f6e6520706572736f6e206f7220656e74697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQG9P7QDw7BufufZW8r16xNRKHvReYC3Cgwgngjq4ufDH")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<WST>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<WST>(10075902696595072969, v0, v1, 0x1::string::utf8(b"https://x.com/WeStandTogethr"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


module 0x2282aa660202720edb18ead7df1377be5e39fc34cb49d11e7a415ff85f1902d8::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"REX", b"SuiRex", b"Sui and Rex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSdMzkyWpF9ANKt6iLFa1dYEozZfKRHcvPKHZoL3o8z5V")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<REX>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<REX>(11003872832174251023, v0, v1, 0x1::string::utf8(b"https://x.com/suirex_/status/1852905685500985755?s=46&t=ThKMZ4N5B_n9DWk689hjGA"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/suirexannouncements"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


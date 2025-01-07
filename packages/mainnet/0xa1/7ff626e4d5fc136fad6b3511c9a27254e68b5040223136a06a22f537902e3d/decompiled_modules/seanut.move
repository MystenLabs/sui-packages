module 0xa17ff626e4d5fc136fad6b3511c9a27254e68b5040223136a06a22f537902e3d::seanut {
    struct SEANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEANUT>(arg0, 6, b"SEANUT", b"Seanut The Suirrel", b"RIP Peanut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmPncTECroMSa7Jxth4R69QNWwssKFFLrQ5Nvh3rFqBiJP")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SEANUT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SEANUT>(11338281239749128815, v0, v1, 0x1::string::utf8(b"https://x.com/theog_peanut"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/seanutsui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


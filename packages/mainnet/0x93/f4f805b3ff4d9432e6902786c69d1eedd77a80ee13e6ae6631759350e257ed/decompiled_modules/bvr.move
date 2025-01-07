module 0x93f4f805b3ff4d9432e6902786c69d1eedd77a80ee13e6ae6631759350e257ed::bvr {
    struct BVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVR>(arg0, 6, b"BVR", b"BeaverSUI", x"2442565220e2809420546865207368617270657374206d6172696e6520617263686974656374732c2074686520426561766572732c206e6f7720746872697665206f6e20746865206d6f737420656666696369656e7420626c6f636b636861696e3a205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmNRrzi7j2Lw4hBZfkFrg17jymuZqSMQa637Bz81xFE7Y3")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<BVR>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<BVR>(6437602911042365766, v0, v1, 0x1::string::utf8(b"https://x.com/BeaverSUI"), 0x1::string::utf8(b"https://suibvr.xyz/"), 0x1::string::utf8(b"https://t.me/+sC2MhQBAnlZlOTY0"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


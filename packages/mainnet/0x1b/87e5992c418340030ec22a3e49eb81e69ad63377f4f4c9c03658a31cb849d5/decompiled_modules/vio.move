module 0x1b87e5992c418340030ec22a3e49eb81e69ad63377f4f4c9c03658a31cb849d5::vio {
    struct VIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIO>(arg0, 6, b"VIO", b"Avior Protocol", b"High Powered Multi-Chain Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmPhNF5RNkBxNrR87TtMGtxsNiRnCs28rDFDDW5J2SXRiZ")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<VIO>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<VIO>(9167840590985881914, v0, v1, 0x1::string::utf8(b"https://x.com/AviorProtocol"), 0x1::string::utf8(b"https://www.aviorprotocol.com/"), 0x1::string::utf8(b"https://t.me/aviorpro"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


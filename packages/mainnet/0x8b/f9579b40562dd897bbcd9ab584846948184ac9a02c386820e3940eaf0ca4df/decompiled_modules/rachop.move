module 0x8bf9579b40562dd897bbcd9ab584846948184ac9a02c386820e3940eaf0ca4df::rachop {
    struct RACHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHOP>(arg0, 6, b"Rachop", b"Rachopsui", x"57697468206d792062756e6e79206279206d7920736964652c20526163686f7020616e6420492074616b652074686520726964652c0a4f6e206c6f6e67206a6f75726e65797320776520676c6964652c207468726f75676820235355492c206f757220647265616d7320636f6c6c69646521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSUPaCSxT5YU6vRgwnKte1VmxHzQVTHcazNx4kwQZpk6B")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<RACHOP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<RACHOP>(9100213806883212433, v0, v1, 0x1::string::utf8(b"https://x.com/RachopSui"), 0x1::string::utf8(b"https://rachop.com"), 0x1::string::utf8(b"https://t.me/RachopSUI"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


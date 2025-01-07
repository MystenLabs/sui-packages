module 0x5332a42fea343f2000831653e898b626e36a03161fe85418d754e32d93756162::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"HOP", b"Hoppy", b"Hoppy the official hop frog of hop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmPVm7QNhstGvhyMnKoYHXVsmuwGRcyT4riAH2Z3cr1MgG")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOP>(14502131699502846682, v0, v1, 0x1::string::utf8(b"https://x.com/HoppyCoinSui"), 0x1::string::utf8(b"https://hoppy-sui.com/"), 0x1::string::utf8(b"https://t.me/HoppyPortalSui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


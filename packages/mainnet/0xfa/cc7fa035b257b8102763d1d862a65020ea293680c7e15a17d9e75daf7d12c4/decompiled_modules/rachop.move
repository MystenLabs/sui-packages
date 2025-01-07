module 0xfacc7fa035b257b8102763d1d862a65020ea293680c7e15a17d9e75daf7d12c4::rachop {
    struct RACHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHOP>(arg0, 6, b"RacHop", b"RacHop", b"With my bunny by my side, Rachop and I take the ride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSGQUYn4MkWnYhmmQCaf7rWtNrd4zcsRt1UWr9HFZ1Mgp")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<RACHOP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<RACHOP>(18277347114329412027, v0, v1, 0x1::string::utf8(b"https://x.com/RachopSui"), 0x1::string::utf8(b"https://rachop.com/"), 0x1::string::utf8(b"https://t.me/RachopSUI"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


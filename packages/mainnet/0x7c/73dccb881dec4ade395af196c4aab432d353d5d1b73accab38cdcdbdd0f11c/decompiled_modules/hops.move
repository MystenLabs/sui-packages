module 0x7c73dccb881dec4ade395af196c4aab432d353d5d1b73accab38cdcdbdd0f11c::hops {
    struct HOPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPS>(arg0, 6, b"HopS", b"HopSoul", b"Swap on @SuiNetwork and Pray Hard for HopSoul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmTDKRGW9SF1yf5ShGVdV6Hr3AbraDP2t7oxPTEgAYgwSj")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPS>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPS>(1353168556021410524, v0, v1, 0x1::string::utf8(b"https://x.com/HopAggregator"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


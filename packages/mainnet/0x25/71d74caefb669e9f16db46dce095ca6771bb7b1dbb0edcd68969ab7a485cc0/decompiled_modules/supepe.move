module 0x2571d74caefb669e9f16db46dce095ca6771bb7b1dbb0edcd68969ab7a485cc0::supepe {
    struct SUPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPEPE>(arg0, 6, b"$SUPEPE", b"SUI PEPE", b"Blue? or Green? You choose your pepe, biggest on chain token by....shhhh Founder reveal on the biggest twitter page of SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmYZov3JKTf297uSHqgMevQZ4TJYzoUH83NhFxriq7yQWV")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUPEPE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUPEPE>(2802146157929951033, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


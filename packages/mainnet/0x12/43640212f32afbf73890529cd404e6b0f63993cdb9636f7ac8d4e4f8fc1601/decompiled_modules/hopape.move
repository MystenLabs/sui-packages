module 0x1243640212f32afbf73890529cd404e6b0f63993cdb9636f7ac8d4e4f8fc1601::hopape {
    struct HOPAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPAPE>(arg0, 6, b"HopApe", b"HopApe", b"HopApe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmeCQDaeW7MJoZpHHgNU3jbyrquuugPKM2DZYv5L6wLJbc")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPAPE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPAPE>(83737127440983235, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


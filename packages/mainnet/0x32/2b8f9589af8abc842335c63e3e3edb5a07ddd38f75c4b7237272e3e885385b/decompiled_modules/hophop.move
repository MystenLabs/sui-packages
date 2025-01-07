module 0x322b8f9589af8abc842335c63e3e3edb5a07ddd38f75c4b7237272e3e885385b::hophop {
    struct HOPHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPHOP>(arg0, 6, b"hophop", b"Hophop", b"hophophophophophophophophophophophophophop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmbuMR86qgMrUYzxQTVHbdT4o8Ugc2ZnyaUG8v4YSHCKnu")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPHOP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPHOP>(12746147286584077675, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


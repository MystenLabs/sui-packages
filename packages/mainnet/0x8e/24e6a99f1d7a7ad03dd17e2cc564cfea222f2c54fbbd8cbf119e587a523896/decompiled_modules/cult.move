module 0x8e24e6a99f1d7a7ad03dd17e2cc564cfea222f2c54fbbd8cbf119e587a523896::cult {
    struct CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULT>(arg0, 6, b"CULT", b"NOT A CULT", b"is it bad to start a cult ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmT2tzsVVnU6uMYHQL5GHLZfkp9Yw3rB51agq5VkXr9Cpa")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<CULT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<CULT>(16573194008556825473, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


module 0x3cff6237ec738e85ec1781cc087090cbc3cc6ec166ac987bb737fceae14c66c7::hopium {
    struct HOPIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPIUM>(arg0, 6, b"HOPIUM", b"Hopium", b"sometimes you just hop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmaTPnY8SXLci5WsaJ41cDxsLrCWy7sjTiPUVu1prs3GP7")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPIUM>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPIUM>(18229044316589698140, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


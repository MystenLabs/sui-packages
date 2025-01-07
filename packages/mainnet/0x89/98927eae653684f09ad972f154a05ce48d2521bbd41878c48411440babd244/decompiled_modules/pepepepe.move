module 0x8998927eae653684f09ad972f154a05ce48d2521bbd41878c48411440babd244::pepepepe {
    struct PEPEPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEPEPE>(arg0, 6, b"PePePePe", b"SuiPepe", b"Suipepe for the Culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qma5cG1SeSywxE5jWvRPr889mVtJVVa6QNHsHFBUpwutdk")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<PEPEPEPE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<PEPEPEPE>(5409378263402941971, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


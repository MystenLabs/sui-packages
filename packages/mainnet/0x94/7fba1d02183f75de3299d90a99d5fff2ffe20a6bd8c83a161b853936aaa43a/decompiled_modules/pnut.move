module 0x947fba1d02183f75de3299d90a99d5fff2ffe20a6bd8c83a161b853936aaa43a::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"Pnut", b"Obi PNut Kenobi", x"6620796f7520737472696b65206d6520646f776e2c20492077696c6c206265636f6d65206d6f726520706f77657266756c207468616e20796f7520636f756c6420706f737369626c7920696d6167696e65e2809d204f626920504e7574204b656e6f6269206f6e205355490a2d456c6f6e206d75736b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmbZT8enZzdJURSpWyxf6MipPM5UKRXdx93HbDQrfw1m9x")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<PNUT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<PNUT>(11551593712833332939, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


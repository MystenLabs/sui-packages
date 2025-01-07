module 0xcbf8738afe79f682023a8b86e6fc0be1f80f9f04dc172f5f6cb963637d70fca7::lmsh {
    struct LMSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMSH>(arg0, 6, b"LMSH", b"Lets Make Sui Hob Again", x"244c4d5348202d204d616b696e67205375692047726561742c204f6e65204d656d6520617420612054696d652120f09f9a80f09fa4a3204a6f696e20746865206d6f76656d656e742c206272696e6720746865206c61756768732c20616e64206c6574e28099732073656e642053756920746f20746865206d6f6f6e20286f72206174206c6561737420746865206d656d652068616c6c206f662066616d652921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmUw5T6gKUTAuZu8seyWHAQtdWZJ3hdBEQKqy6AzcgHRvt")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<LMSH>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<LMSH>(11844851024527236108, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


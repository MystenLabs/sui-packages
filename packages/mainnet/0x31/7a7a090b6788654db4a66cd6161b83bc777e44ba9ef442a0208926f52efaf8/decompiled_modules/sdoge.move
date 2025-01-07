module 0x317a7a090b6788654db4a66cd6161b83bc777e44ba9ef442a0208926f52efaf8::sdoge {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 6, b"Sdoge", b"Sui Doge", b"From Community to community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSPjQH4nom6qS7ZyV7eB76spSUDSnDCFyasvUbgutcaKx")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SDOGE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SDOGE>(4346858323295720779, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://en.wikipedia.org/wiki/Doge_(meme)"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}


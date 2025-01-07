module 0xbeb8b8c5e2e5adde4fd5e7c7a69fd454c0777e1022f072d89cb76c3dccf89bb8::fins {
    struct FINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FINS>(arg0, 16214562823296588227, b"TUNA", b"FINS", x"53656375726520796f7572206675747572652e2047657420612066696e2d686f6c64206f6e2054554e41206e6f7720f09f8c8af09f909f", b"https://images.hop.ag/ipfs/QmeLpwAZKmxa5xNMw91nwGhrgZWhhbzakh7Baff8hxyK9q", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


module 0xc1731d84a4feb4f8db907a4617dcd7818ee8febe43ff55b74890c83714339ca5::cwak {
    struct CWAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWAK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CWAK>(arg0, 2982165576145770099, b"ChimpWithAk", b"CWAK", b"An armed chimp looking for who stole its banana", b"https://images.hop.ag/ipfs/QmYQreH9jrVLcrTPmvFi9PFdn7CahUXCdBgZHcv85yy6KC", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


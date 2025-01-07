module 0x57964fab48b9a9ac6a268e3d9280c0aadae54bc1330de4651e7ac196f273a5f3::baddies {
    struct BADDIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADDIES, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BADDIES>(arg0, 15399818106941281623, b"baddies", b"baddies ", b"baddies", b"https://images.hop.ag/ipfs/QmX2eG8ikn9XjDKgE43c8SveA9C7vBM6zT3BPeyJgTYQqq", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


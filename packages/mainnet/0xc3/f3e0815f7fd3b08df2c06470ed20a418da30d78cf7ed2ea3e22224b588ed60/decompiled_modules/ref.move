module 0xc3f3e0815f7fd3b08df2c06470ed20a418da30d78cf7ed2ea3e22224b588ed60::ref {
    struct REF has drop {
        dummy_field: bool,
    }

    fun init(arg0: REF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<REF>(arg0, 975134437023420513, b"referalss", b"REF", b"my referals love you", b"https://images.hop.ag/ipfs/QmRXuXCrSmF1PSqtB4TRvYQs7yh9rFvPW2qkzNNHxQbVq9", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


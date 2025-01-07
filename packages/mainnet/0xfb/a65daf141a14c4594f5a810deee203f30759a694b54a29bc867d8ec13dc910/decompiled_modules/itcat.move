module 0xfba65daf141a14c4594f5a810deee203f30759a694b54a29bc867d8ec13dc910::itcat {
    struct ITCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ITCAT>(arg0, 10256606585398545637, b"PENNYWISE", b"ITCAT", x"4120776973652070656e6e792070696e6368696e6720636174207468617420656e6a6f79732020636c6f776e7320616e642062616c6c6f6f6e7320f09f8e88", b"https://images.hop.ag/ipfs/QmNxsKGu6avupXpTvmFWZHcAPgigqTGuUNuDYqdLHq8JvR", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


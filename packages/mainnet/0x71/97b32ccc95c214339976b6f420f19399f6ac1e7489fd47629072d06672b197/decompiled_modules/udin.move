module 0x7197b32ccc95c214339976b6f420f19399f6ac1e7489fd47629072d06672b197::udin {
    struct UDIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<UDIN>(arg0, 10537724144977753994, b"PEJUANG SEMUT", b"UDIN", b"TESTHOPTOT", b"https://images.hop.ag/ipfs/QmUknGMCnzTs9LVGnHHqwAxXf9YRZ3NvXswACQNbpbJSZr", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


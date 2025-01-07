module 0x12044ebd2e6e10b2521430730c5c28edd0bd2201d55900dbbce2e34defad4b8::taek {
    struct TAEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAEK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<TAEK>(arg0, 3087219854427805090, b"Taek", b"Taek", b"asdad", b"https://images.hop.ag/ipfs/QmUknGMCnzTs9LVGnHHqwAxXf9YRZ3NvXswACQNbpbJSZr", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


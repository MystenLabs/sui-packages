module 0x95bcf12f4f466e215a33dc2182bb35957f773679073daf3b2e32ee525b4d0469::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<WOOF>(arg0, 12705339953903092625, b"Test Dog", b"WOOF", b"test token", b"https://images.hop.ag/ipfs/QmfUXErcnyC1tsXTMEmYzeXZR6RywxuZBBJw5dLwKdWVt5", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


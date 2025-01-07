module 0xebc6e98aa8c70c0b3f3ab47b30dfa40752dee89db656febd53b5ece247c5279a::sql {
    struct SQL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SQL>(arg0, 2200767578586928597, b"Suiquirrel", b"SQL", b"Let's go to the moon!", b"https://images.hop.ag/ipfs/QmaoEHS1gUBJFYS6XMcKCMYWijgst2TH5dWNEv8ouMx3xz", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


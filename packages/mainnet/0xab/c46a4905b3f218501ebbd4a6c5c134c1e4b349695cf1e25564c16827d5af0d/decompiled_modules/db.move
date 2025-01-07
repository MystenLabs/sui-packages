module 0xabc46a4905b3f218501ebbd4a6c5c134c1e4b349695cf1e25564c16827d5af0d::db {
    struct DB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DB>(arg0, 6473806538064075481, b"DataBunnyLLC", b"DB", b"The token representing DataBunnyLLC, an MSP startup based near Chicago, IL. We help manage and bring networking solutions to small and medium sized businesses.", b"https://images.hop.ag/ipfs/QmNzbzy2wsX7SJoxbPjzSNGyR8yHdLBd29MqEurPg8i4HB", 0x1::string::utf8(b"https://x.com/DataBunnyLLC"), 0x1::string::utf8(b"https://www.databunnyllc.org"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


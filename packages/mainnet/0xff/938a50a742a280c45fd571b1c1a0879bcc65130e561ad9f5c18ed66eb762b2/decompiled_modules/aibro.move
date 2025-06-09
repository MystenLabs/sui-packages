module 0xff938a50a742a280c45fd571b1c1a0879bcc65130e561ad9f5c18ed66eb762b2::aibro {
    struct AIBRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIBRO>(arg0, 6, b"AIBRO", b"AI BRO", x"414942524f20697320796f75722068616c6c7563696e6174696e672041492062726f206f6e2d636861696e2e2049742077617320626f726e2066726f6d20746f6f206d616e79206c6174652d6e6967687420646567656e207477656574732c20616e64206f6666657273207a65726f207574696c69747920657863657074206d616b696e6720796f75206c617567682c206372792c20616e6420706572686170732070757368696e6720746f77617264732061202431304d206d61726b6574206361702e0a0a506f7765726564206279205375692c206675656c6564206279206d656d65732c20616e6420676f7665726e6564206279206368616f732e204c6574207468652068616c6c7563696e6174696f6e7320626567696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicf3ijcb5cpcthjxomzmupozlkqnwsjdkmtuolq6cpa2wf5qdliyu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIBRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIBRO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


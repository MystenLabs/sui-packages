module 0xfba978399a637686b6c3f52c3cd5d21f119a97c413a63a11a90c0a1216d42532::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CAT>(arg0, 8703574296312357151, b"cat", b"cat", b"Cat is Cool", b"https://images.hop.ag/ipfs/QmcSEkKNgKNLvbAosMr6e9qdEfKyFVL98VJNT4e977BdXA", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


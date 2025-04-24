module 0x56e22e7db7001e45a9655461dd4f36e506b7f53ad4dfc274b237a6041b3566f6::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        0x3f76de50456b55909e8d81b72e42d138a17a742e4e1e65ea34bb23d4292edd68::connector_v3::new<MEME>(arg0, 254788503, b"MEME", b"meme", b"memememe", b"https://ipfs.io/ipfs/bafkreief2yhdjb55o2hmol5bsdzjjvyy4oxd7saotppmbmsxe5ptnbrxau", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}


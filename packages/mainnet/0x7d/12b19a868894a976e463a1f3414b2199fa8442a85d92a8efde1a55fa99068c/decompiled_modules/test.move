module 0x7d12b19a868894a976e463a1f3414b2199fa8442a85d92a8efde1a55fa99068c::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0xd51307d2235e10c4ce65d838f7e49a7447be439e03fc9fd9f3b7295fd09a6e84::connector_v3::new<TEST>(arg0, 45852476, b"TST", b"test", b"tst", b"https://ipfs.io/ipfs/bafybeiagavcwpa6fcza4cow4ozobdm6pnnsiq4cqgetbfmc76mdggqir3m", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}


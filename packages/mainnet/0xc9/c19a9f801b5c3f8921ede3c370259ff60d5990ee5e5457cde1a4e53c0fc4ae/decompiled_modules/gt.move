module 0xc9c19a9f801b5c3f8921ede3c370259ff60d5990ee5e5457cde1a4e53c0fc4ae::gt {
    struct GT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GT, arg1: &mut 0x2::tx_context::TxContext) {
        0x88a1a68c37327bddab2aa4117b938d52e64a0a04cf8809206bcd46217b6f3cd4::connector_v3::new<GT>(arg0, 38295346, b"GBG", b"gt", b"gg", b"https://ipfs.io/ipfs/bafybeiemkpmir7z4xvwt6ivja6zmbayfipxltcxcsnfmnqmaqlqvap4lpm", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}


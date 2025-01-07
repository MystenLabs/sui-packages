module 0xfe36e76371198727f261a0bc38b864cb99fee1cf39fe0fe22e5a5a55130037d6::sex {
    struct SEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEX, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SEX>(arg0, 3220333408333633012, b"Sui Exchange Xploit", b"SEX", x"f09f9a80205669727475616c206d696e696e67206f6e2053554921204275696c642c206d696e652c20616e64206561726e202453455820746f6b656e7320776974686f7574207468652068617264776172652e20f09f8cb12045636f2d667269656e646c7920262066756e2e204a6f696e2074686520535549456e6572677958706c6f6974207265766f6c7574696f6e2120f09f92a1", b"https://images.hop.ag/ipfs/QmeScpeVFdQDrxZej3Mccrrp9ZDkNmfGrim5pubw3KnVVW", 0x1::string::utf8(b"https://x.com/SUIEnergyXploit"), 0x1::string::utf8(b"https://www.suixploit.app/"), 0x1::string::utf8(b"https://t.me/SUIEnergyXploit"), arg1);
    }

    // decompiled from Move bytecode v6
}


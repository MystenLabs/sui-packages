module 0x55ab3c5c404eff25641ac875c3c7aa41e8f88a4b14bda2e31c12def039b4956::snuf {
    struct SNUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SNUF>(arg0, 16605943007929159609, b"Snuf", b"SNUF", b"Snuf is the dog whose character will definitely save the world from drowning in self esteem", b"https://images.hop.ag/ipfs/QmQEPHtuit1GUgn5C73cikEmno9zkGxGubJNxq3RFW8Yv1", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


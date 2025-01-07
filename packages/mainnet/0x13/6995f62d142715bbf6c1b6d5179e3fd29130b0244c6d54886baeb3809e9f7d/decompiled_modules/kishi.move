module 0x136995f62d142715bbf6c1b6d5179e3fd29130b0244c6d54886baeb3809e9f7d::kishi {
    struct KISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISHI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<KISHI>(arg0, 8832724952908746423, b"kishi", b"kishi", b"kishi is a meme coin created for fun", b"https://images.hop.ag/ipfs/QmUY68pDQyDxWJ4TazKh5QDhbAELGz5BRTSsw8d6z8MPWa", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


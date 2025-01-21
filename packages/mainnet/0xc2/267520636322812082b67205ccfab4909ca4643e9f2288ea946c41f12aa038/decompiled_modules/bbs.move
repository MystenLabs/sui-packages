module 0xc2267520636322812082b67205ccfab4909ca4643e9f2288ea946c41f12aa038::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BBS>(arg0, 12616226764478042083, b"Baby Shark", b"BBS", b"none", b"https://images.hop.ag/ipfs/QmfMqCYYK7ZfrW9VNPo7Vjm1NuHzLxyEkbfA91F4G3Jcgv", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


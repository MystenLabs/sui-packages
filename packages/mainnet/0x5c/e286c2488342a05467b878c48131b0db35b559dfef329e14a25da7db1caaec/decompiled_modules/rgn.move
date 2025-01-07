module 0x5ce286c2488342a05467b878c48131b0db35b559dfef329e14a25da7db1caaec::rgn {
    struct RGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<RGN>(arg0, 9198927999116273168, b"Reign", b"RGN", b"Reign is the first fun coin to Hold royal coin,rules over kings and queens sovereign on ecosystem", b"https://images.hop.ag/ipfs/QmZTFdynBBytRwLdpBECWttf6ZGWvrvKdQouxeYTQTZB1a", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


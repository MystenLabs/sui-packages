module 0xa4ed6f439b85b75d83fbda3df6c032c049263f753da8d8808ce37c30f5455523::fine {
    struct FINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FINE>(arg0, 14530396464100053110, b"THIS IS FINE", b"FINE", b"I always got rugged on every memecoin that i buy, but i'm fine.", b"https://images.hop.ag/ipfs/QmYaSksGiWCnim2DtYyYnVjNFoWa6DyU3QXqnUwQvaM621", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


module 0xd299643fe8edbfa705a8f56034c9030534c4f17877289ebce80ee50b15e50cf0::ggm {
    struct GGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GGM>(arg0, 17860351034224003485, b"Golden Goose Media", b"GGM", b"Come and join us on this journey!  Ai driven media company looking to be number 1 news source for crypto news!", b"https://images.hop.ag/ipfs/QmSbpAMwavAoCJcW3usZReXxBUtRooY5QByjvWoALr8rQ6", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


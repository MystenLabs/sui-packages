module 0xd674aa24eb0d8c298abbb1171667c6dc647207dc25d80b7ce7c0078c2fb6960c::bbp {
    struct BBP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BBP>(arg0, 14514962197761095695, x"42c4b04720424c41434b2050454e4ec4b053", b"BBP", b"more than a penis", b"https://images.hop.ag/ipfs/QmUXXhvjzfLNQgZ4otKC1Mka2bhBP8jZj33GWhyJrDdf4p", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


module 0xca5e6b2bd1981118e8910aa210e8695ed4db5248050ac893a27e06bcaeedad92::suing {
    struct SUING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUING, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUING>(arg0, 17229093219144878196, b"SUING", b"SUING", b"Time to party on suing.", b"https://images.hop.ag/ipfs/QmSafjjcmx1MFFwsgi6prV9CYnG7LrTtUQJUxSKNV72otg", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


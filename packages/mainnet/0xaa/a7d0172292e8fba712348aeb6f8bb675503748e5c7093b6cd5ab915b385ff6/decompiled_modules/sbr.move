module 0xaaa7d0172292e8fba712348aeb6f8bb675503748e5c7093b6cd5ab915b385ff6::sbr {
    struct SBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBR, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SBR>(arg0, 8561351485762736701, b"Strategic Bitcoin Reserve", b"SBR", b"Parody of Strategic Bitcoin Reserve, owned and operated by SBR Community Take Over (CT0)", b"https://images.hop.ag/ipfs/QmVy1wWhGNBnHUS8foXZx7BsWGxqkX2oEkobn58pWjuzxs", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


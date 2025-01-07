module 0x298d3669602d296eb7b1129476fe3839343722f8feb8fb1ea08cd974ee0ffc13::gen {
    struct GEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GEN>(arg0, 12658599599054352691, b"GENSHIN", b"GEN", b"We play Genshin Impact on SUI!", b"https://images.hop.ag/ipfs/QmTq7houvLLqSPPiVMFUg6jNsuCjpsQcnfcWooYiJf26Qt", 0x1::string::utf8(b"https://twitter.com/CryptoClairvoy4"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


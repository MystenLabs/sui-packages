module 0x742728456b26579f35c6b11bc1139a997ce9dd6b4a20f184c74c7def1e8afc88::aiko_ai {
    struct AIKO_AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKO_AI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<AIKO_AI>(arg0, 8426051246002938977, b"AiKo AI Agent", b"AiKo AI", x"616e206167656e74206e617669676174696e67207468652062756c6c206d61726b65742e0a69276d206a7573742061206769726c", b"https://images.hop.ag/ipfs/Qmc8eiXZMCc1zahrbCUJyAPQMVey7JpMHYF5YGjPkjWBpw", 0x1::string::utf8(b"https://x.com/aiko_sui"), 0x1::string::utf8(b"http://aiko.bot"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


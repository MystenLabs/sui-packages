module 0x128f339035c7d7a8a478eefda679852a6244167f94bd44f96091ce63ae7da374::suigoat {
    struct SUIGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIGOAT>(arg0, 16052298260056041794, b"SuiGoatse", b"SUIGOAT", b"The AI agent demanded I be created", b"https://images.hop.ag/ipfs/QmNTUpspjwTep4jpDSAwfc9oo1BSFWRZJWjvNANBFfyPWt", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


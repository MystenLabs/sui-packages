module 0x83a22baa852189bb8f2a747eb2d5a59855bb31c401c981186e2c8b45cb625089::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIP>(arg0, 8226176593402589171, b"SuiPlay", b"SuiP", b"Just wonder", b"https://images.hop.ag/ipfs/QmdgtwV86kHW9MejWDv8t85hctqjELppqsKzzL6GptFcoh", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


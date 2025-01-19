module 0x5079e15a6cead81f0342084112c7c218344cbef74a288c94203b86bd787e986b::israel_peace {
    struct ISRAEL_PEACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISRAEL_PEACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ISRAEL_PEACE>(arg0, 16082282431086343297, b"Israel", b"Israel peace ", b"This token is based on Israeli -Palestinian peace, so the results", b"https://images.hop.ag/ipfs/QmUVy3rBHv6B6RAtKnVbrXfqSaAL7ryPi14mKCuisdDp1r", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


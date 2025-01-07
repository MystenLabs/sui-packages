module 0xbe5f75816d6c2f66b5c740be6adc39181802b41c4ee5a4846f255836b039ea4a::sbt {
    struct SBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SBT>(arg0, 7319880272446205535, b"SuiBetterTogether", b"SBT", b"Solid/Sui - Better/Big - Together/To All", b"https://images.hop.ag/ipfs/QmaX87aQGCiFKDicEzznGtsUTZCEwDxWm5nY9v9fJbihng", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


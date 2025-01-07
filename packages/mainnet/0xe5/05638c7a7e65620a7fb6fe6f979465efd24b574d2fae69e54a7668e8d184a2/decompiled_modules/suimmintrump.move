module 0xe505638c7a7e65620a7fb6fe6f979465efd24b574d2fae69e54a7668e8d184a2::suimmintrump {
    struct SUIMMINTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMMINTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIMMINTRUMP>(arg0, 15678711796095946251, b"SuiTrump", b"SuimminTrump", b"Definitive degenerative parabolic memecoin.", b"https://images.hop.ag/ipfs/QmSuPHFLxh3CvHEQoaQ4KpKw9Vq9KtQq1RXaXv2MKRhQuP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


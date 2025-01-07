module 0xf8937b4ba63340a538e5ad994c8d2f1f91ed5364e89bd86a6b1d14afa8c24995::trumppoy {
    struct TRUMPPOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPPOY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TRUMPPOY>(arg0, 8256050631255752543, b"Trump Person of the Year", b"TRUMPPOY", b"In honor of the 2024 Person of the Year Donald Trump!!", b"https://images.hop.ag/ipfs/QmbUWEMEMcJ8sZZeUEDzH3kUvJEqcF44cpAv1Fpgq3Yyqk", 0x1::string::utf8(b"https://x.com/POY_Trump2024"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


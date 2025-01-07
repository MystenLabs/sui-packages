module 0x5b78ff5a0cee0bcef8e6980ff404221bfbfe57552cf90dd554b462a916180620::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PIKA>(arg0, 11765062645150787054, b"PikaSui", b"PIKA", x"50696b61636875206f6e20537569203d2050696b615375692e0a0a583a2068747470733a2f2f782e636f6d2f70696b615f7375690a54656c656772616d3a2068747470733a2f2f742e6d652f50696b6153756943686174", b"https://images.hop.ag/ipfs/QmWCKWXkuJ5FrRqvi9skMFVgrYoye51zEhjQzwAk2YHvds", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


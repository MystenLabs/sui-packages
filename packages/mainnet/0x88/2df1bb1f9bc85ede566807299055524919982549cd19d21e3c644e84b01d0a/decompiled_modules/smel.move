module 0x882df1bb1f9bc85ede566807299055524919982549cd19d21e3c644e84b01d0a::smel {
    struct SMEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SMEL>(arg0, 12625066301929086333, b"Skibidi Meme Lord", b"SMEL", b"Skibidi Meme Lord", b"https://images.hop.ag/ipfs/QmPTMpHpBCtvNHBRtowQ3pXeBNKtiR2WdP8sX14Su595pn", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


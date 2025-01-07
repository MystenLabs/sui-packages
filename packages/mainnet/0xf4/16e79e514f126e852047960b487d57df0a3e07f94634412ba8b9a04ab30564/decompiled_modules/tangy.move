module 0xf416e79e514f126e852047960b487d57df0a3e07f94634412ba8b9a04ab30564::tangy {
    struct TANGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TANGY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TANGY>(arg0, 9215023006498500330, b"tangy", b"tangy", b"The most tangy of tokens", b"https://images.hop.ag/ipfs/QmQSd5maw4rSPHu6BHdh1vFavDJUbHqmQFhaVrNq2WsETb", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


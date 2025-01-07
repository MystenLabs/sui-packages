module 0xdc06bbbc7de2fe5104a99a1bb6ec8e2b30f9c97538107a6290e6cd97574ba5fd::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<UNI>(arg0, 3789019347408817603, b"Uni Dog", b"UNI", x"5468652053756920666f756e646572e280997320646f6720556e69206f6e2053756921", b"https://images.hop.ag/ipfs/QmRuGHuPbusukTAchkor6P4KWCD9mpBNozbTjXBciWyEYt", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


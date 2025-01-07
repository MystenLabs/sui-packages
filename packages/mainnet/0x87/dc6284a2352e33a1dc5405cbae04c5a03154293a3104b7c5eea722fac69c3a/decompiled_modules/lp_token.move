module 0x87dc6284a2352e33a1dc5405cbae04c5a03154293a3104b7c5eea722fac69c3a::lp_token {
    struct LP_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<LP_TOKEN>(arg0, 6, b"Lotus LP Token", b"LFLP", b"LP token for Lotus Finance", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<LP_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LP_TOKEN>>(v2);
        0x87dc6284a2352e33a1dc5405cbae04c5a03154293a3104b7c5eea722fac69c3a::teller::new<LP_TOKEN>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}


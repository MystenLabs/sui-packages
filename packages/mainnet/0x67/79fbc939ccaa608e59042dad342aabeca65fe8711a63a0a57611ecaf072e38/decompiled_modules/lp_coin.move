module 0x6779fbc939ccaa608e59042dad342aabeca65fe8711a63a0a57611ecaf072e38::lp_coin {
    struct LP_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_COIN>(arg0, 9, b"LP", b"LP", b"LP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LP_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x477ed3fbe5b116a2a20d89a7948cfc494bbd212af76ef1cbfcf4ea4273852977::proteus {
    struct PROTEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROTEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTEUS>(arg0, 9, b"PROTEUS", b"Proteus", b"Nereus Proteus vault coin: an ETH + stablecoin basket.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROTEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTEUS>>(v1);
    }

    // decompiled from Move bytecode v7
}


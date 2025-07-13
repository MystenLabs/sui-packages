module 0xe4ff5fcc935fddaf808e27017c994b9cd75eaac81cec4bd2b4b8fdeb05a71e07::ywbtc {
    struct YWBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YWBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YWBTC>(arg0, 8, b"yWBTC", b"Kai Vault wBTC", b"Kai Vault yield-bearing wBTC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YWBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YWBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


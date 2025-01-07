module 0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin {
    struct LAOLONG1994_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAOLONG1994_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAOLONG1994_FAUCET_COIN>(arg0, 8, b"Laolong1994_faucet_coin", b"Laolong1994_faucet_coin", b"this is Laolong1994_faucet_coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAOLONG1994_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LAOLONG1994_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}


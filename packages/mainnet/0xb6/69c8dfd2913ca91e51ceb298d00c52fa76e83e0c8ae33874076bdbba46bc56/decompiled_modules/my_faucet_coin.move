module 0xb669c8dfd2913ca91e51ceb298d00c52fa76e83e0c8ae33874076bdbba46bc56::my_faucet_coin {
    struct MY_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_FAUCET_COIN>(arg0, 8, b"BenjaminHangFaucet", b"BenjaminHangFaucet", b"BenjaminHang's faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MY_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}


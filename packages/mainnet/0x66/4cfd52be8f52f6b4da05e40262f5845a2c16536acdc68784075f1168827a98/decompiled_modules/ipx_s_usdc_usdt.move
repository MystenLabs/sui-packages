module 0x664cfd52be8f52f6b4da05e40262f5845a2c16536acdc68784075f1168827a98::ipx_s_usdc_usdt {
    struct IPX_S_USDC_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_S_USDC_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_S_USDC_USDT>(arg0, 9, b"ipx-s-usdc-usdt", b"iUSDC/USDT", b"CLAMM Interest Protocol LpCoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_S_USDC_USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_S_USDC_USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}


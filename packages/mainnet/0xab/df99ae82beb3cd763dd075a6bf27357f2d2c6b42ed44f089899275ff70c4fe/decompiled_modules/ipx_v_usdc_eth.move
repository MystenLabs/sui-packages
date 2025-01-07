module 0xabdf99ae82beb3cd763dd075a6bf27357f2d2c6b42ed44f089899275ff70c4fe::ipx_v_usdc_eth {
    struct IPX_V_USDC_ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_V_USDC_ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_V_USDC_ETH>(arg0, 9, b"ipx-v-usdc-eth", b"BTC/USDT", b"CLAMM Interest Protocol LpCoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_V_USDC_ETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_V_USDC_ETH>>(v1);
    }

    // decompiled from Move bytecode v6
}


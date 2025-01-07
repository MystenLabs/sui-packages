module 0x82e48c9d484632c185369e20743bea834d434855798a28e85e9ba8ac139f89a9::ipx_v_usdc_boden {
    struct IPX_V_USDC_BODEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_V_USDC_BODEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_V_USDC_BODEN>(arg0, 9, b"ipx-v-usdc-boden", b"USDC/ETH", b"CLAMM Interest Protocol LpCoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_V_USDC_BODEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_V_USDC_BODEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


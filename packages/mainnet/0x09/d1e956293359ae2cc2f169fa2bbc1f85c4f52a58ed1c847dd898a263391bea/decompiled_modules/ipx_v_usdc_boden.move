module 0x9d1e956293359ae2cc2f169fa2bbc1f85c4f52a58ed1c847dd898a263391bea::ipx_v_usdc_boden {
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


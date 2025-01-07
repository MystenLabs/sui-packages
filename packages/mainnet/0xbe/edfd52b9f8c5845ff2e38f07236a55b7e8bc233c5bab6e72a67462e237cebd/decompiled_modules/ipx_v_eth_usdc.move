module 0xbeedfd52b9f8c5845ff2e38f07236a55b7e8bc233c5bab6e72a67462e237cebd::ipx_v_eth_usdc {
    struct IPX_V_ETH_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_V_ETH_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_V_ETH_USDC>(arg0, 9, b"ipx-v-eth-usdc", b"BTC/USDT", b"CLAMM Interest Protocol LpCoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_V_ETH_USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_V_ETH_USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}


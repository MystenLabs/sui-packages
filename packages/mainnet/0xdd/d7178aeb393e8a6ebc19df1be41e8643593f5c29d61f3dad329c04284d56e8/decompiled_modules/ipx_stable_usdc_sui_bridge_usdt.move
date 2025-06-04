module 0xddd7178aeb393e8a6ebc19df1be41e8643593f5c29d61f3dad329c04284d56e8::ipx_stable_usdc_sui_bridge_usdt {
    struct IPX_STABLE_USDC_SUI_BRIDGE_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_STABLE_USDC_SUI_BRIDGE_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_STABLE_USDC_SUI_BRIDGE_USDT>(arg0, 9, b"s-USDC/suiUSDT", b"Stable LP Coin for USDC/suiUSDT", b"Interest Protocol Stable Swap Lp Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://interestprotocol.infura-ipfs.io/ipfs/QmYiRY9bcN")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_STABLE_USDC_SUI_BRIDGE_USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_STABLE_USDC_SUI_BRIDGE_USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}


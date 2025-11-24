module 0x6d9fc33611f4881a3f5c0cd4899d95a862236ce52b3a38fef039077b0c5b5834::btc_usdc {
    struct BtcUSDC has key {
        id: 0x2::object::UID,
    }

    public fun create_stable<T0>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<BtcUSDC>(arg0, decimals(), 0x1::string::utf8(b"btcUSDC"), 0x1::string::utf8(b"btcUSDC"), 0x1::string::utf8(b"Mint btcUSD with USDC and earn BTC"), 0x1::string::utf8(b"https://circle.com/usdc-icon"), arg3);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BtcUSDC>>(0x2::coin_registry::finalize<BtcUSDC>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::default<BtcUSDC, T0>(arg1, v1, arg2, arg3);
    }

    public fun decimals() : u8 {
        6
    }

    // decompiled from Move bytecode v6
}


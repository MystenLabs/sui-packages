module 0x67fa77df147ddd7ef83be5f77c0c90c5b930e84760bc39b5b9ea008b0dd7169e::btc_usd {
    struct BTC_USD has key {
        id: 0x2::object::UID,
    }

    public fun create_stable<T0>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory::StableRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<BTC_USD>(arg0, decimals(), 0x1::string::utf8(b"btcUSD"), 0x1::string::utf8(b"btcUSD"), 0x1::string::utf8(b"Mint btcUSD with USDC and earn BTC"), 0x1::string::utf8(b"https://circle.com/usdc-icon"), arg2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BTC_USD>>(0x2::coin_registry::finalize<BTC_USD>(v0, arg2), 0x2::tx_context::sender(arg2));
        0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory::default<BTC_USD, T0>(arg1, v1, arg2);
    }

    public fun decimals() : u8 {
        6
    }

    // decompiled from Move bytecode v6
}


module 0xf06c7f04cc273bda0c4bd96f96f72208471354f973da39b2efbf328c5fcd361a::scallop_bridge {
    public fun deposit_to_scallop<T0>(arg0: &mut 0x6c2253fbe17a6bc64f1b822362be44da9627d10e4bdb6c54d56a528ec58989da::market::Market, arg1: &0x6c2253fbe17a6bc64f1b822362be44da9627d10e4bdb6c54d56a528ec58989da::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6c2253fbe17a6bc64f1b822362be44da9627d10e4bdb6c54d56a528ec58989da::reserve::MarketCoin<T0>> {
        0x6c2253fbe17a6bc64f1b822362be44da9627d10e4bdb6c54d56a528ec58989da::mint::mint<T0>(arg1, arg0, arg3, arg2, arg4)
    }

    public fun withdraw_from_scallop<T0>(arg0: &mut 0x6c2253fbe17a6bc64f1b822362be44da9627d10e4bdb6c54d56a528ec58989da::market::Market, arg1: &0x6c2253fbe17a6bc64f1b822362be44da9627d10e4bdb6c54d56a528ec58989da::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x6c2253fbe17a6bc64f1b822362be44da9627d10e4bdb6c54d56a528ec58989da::reserve::MarketCoin<T0>>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6c2253fbe17a6bc64f1b822362be44da9627d10e4bdb6c54d56a528ec58989da::redeem::redeem<T0>(arg1, arg0, arg3, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}


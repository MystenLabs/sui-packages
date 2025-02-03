module 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::lending_withdraw {
    public fun withdraw<T0>(arg0: &mut 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::market::Market, arg1: 0x2::coin::Coin<0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::pool::PoolLpCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::market::handle_withdraw<T0>(arg0, 0x2::coin::into_balance<0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::pool::PoolLpCoin<T0>>(arg1), 0x2::clock::timestamp_ms(arg2) / 1000), arg3)
    }

    // decompiled from Move bytecode v6
}


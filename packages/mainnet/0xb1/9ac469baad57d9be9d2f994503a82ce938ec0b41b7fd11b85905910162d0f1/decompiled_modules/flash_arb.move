module 0xb19ac469baad57d9be9d2f994503a82ce938ec0b41b7fd11b85905910162d0f1::flash_arb {
    struct State has store, key {
        id: 0x2::object::UID,
    }

    public fun execute_arbitrage<T0>(arg0: &mut 0xdee9::clob::Pool<0x2::sui::SUI, T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public fun validate_pool<T0, T1>(arg0: &0xdee9::clob::Pool<T0, T1>) : bool {
        true
    }

    // decompiled from Move bytecode v7
}


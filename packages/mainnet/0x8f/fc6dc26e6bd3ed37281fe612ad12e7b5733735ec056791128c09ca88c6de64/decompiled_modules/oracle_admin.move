module 0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::oracle_admin {
    public fun register_pyth_feed<T0>(arg0: &0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::x_oracle::AdminCap, arg1: &mut 0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::x_oracle::XOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: u64) {
        abort 0
    }

    public fun update_price_delay_tolerance_ms(arg0: &0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::x_oracle::AdminCap, arg1: &mut 0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::x_oracle::XOracle, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}


module 0xedbba6054c145adf70453eb2ddfa3a4939d3c956818ffa3c2353c65bd3210c90::adaptor_cex {
    public fun update_price<T0>(arg0: &mut 0xedbba6054c145adf70453eb2ddfa3a4939d3c956818ffa3c2353c65bd3210c90::pyth_oracle::Oracle, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xedbba6054c145adf70453eb2ddfa3a4939d3c956818ffa3c2353c65bd3210c90::pyth_oracle::update_price_cex(arg0, 0x1::type_name::with_defining_ids<T0>(), 3, arg1, 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

